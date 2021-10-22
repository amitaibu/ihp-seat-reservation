module Web.Job.Reservation where

import Web.Controller.Prelude
import Control.Concurrent (forkIO, threadDelay)
import Web.Mail.Reservations.Confirmation
import Web.Controller.Reservations
import Data.Set (fromList, toList, delete)


instance Job ReservationJob where
    perform ReservationJob { .. } = do
        -- threadDelay (2 * 1000000)
        reservation <- fetch reservationId
        libraryOpening <- fetch (get #libraryOpeningId reservation)
        library <- fetch (get #libraryId libraryOpening)

        -- Other reservations
        otherReservations <- query @Reservation
            -- Related Reservations.
            |> filterWhere (#libraryOpeningId, get #id libraryOpening)
            -- Exclude current reservation.
            |> filterWhereNot (#id, get #id reservation)
            -- Fetch only Accepted items.
            |> filterWhere (#status, Accepted)
            |> fetch

        reservation
            |> validateStudentIdentifier
            |> assignSeatNumber library otherReservations
            |> ifValid \case
                Left reservation -> do

                    reservation <- reservation
                        |> set #status Rejected
                        |> updateRecord


                    pure ()
                Right reservation -> do
                    reservation <-
                        reservation
                            |> set #status Accepted
                            |> updateRecord


                    -- Don't delay the job for sending an email.
                    forkIO $ sendMail ConfirmationMail{..}

                    pure ()

        pure ()

    maxAttempts = 1

    maxConcurrency = 1

assignSeatNumber library otherReservations reservation =
    let
        assignedSeatNumbers = map (get #seatNumber) otherReservations
            |> Data.Set.fromList
            |> Data.Set.delete 0
            |> Data.Set.toList

        totalNumberOfSeats = get #totalNumberOfSeats library
    in
    if length assignedSeatNumbers >= totalNumberOfSeats
        then reservation |> attachFailure #seatNumber "All seats are already taken"
        else
            -- Find and assign a seat.
            let
                allSeats = [1 .. totalNumberOfSeats]
                seatNumber = (allSeats \\ assignedSeatNumbers) |> head |> fromMaybe 0
            in
                reservation |> set #seatNumber seatNumber





