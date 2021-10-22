module Web.Controller.Reservations where

import Web.Controller.Prelude
import Web.View.Reservations.Index
import Web.View.Reservations.New
import Web.View.Reservations.Edit
import Web.View.Reservations.Show
import Web.Mail.Reservations.Confirmation
import Data.Either (isLeft)
import Data.Text (length)

instance Controller ReservationsController where
    action ReservationsAction {..} = do
        reservations <- query @Reservation |> fetch
        libraryOpening <- fetch libraryOpeningId
        render IndexView { .. }

    action NewReservationAction {..} = do
        let reservation = newRecord |> set #libraryOpeningId libraryOpeningId
        libraryOpening <- fetch libraryOpeningId
        library <- fetch (get #libraryId libraryOpening)
        render NewView { .. }

    action ShowReservationAction { reservationId } = do
        reservation <- fetch reservationId
        libraryOpening <- fetch (get #libraryOpeningId reservation)
        render ShowView { .. }

    action EditReservationAction { reservationId } = do
        reservation <- fetch reservationId
        libraryOpening <- fetch (get #libraryOpeningId reservation)
        render EditView { .. }

    action UpdateReservationAction { reservationId } = do
        reservation <- fetch reservationId
        reservation
            |> buildReservation
            |> ifValid \case
                Left reservation -> do
                    libraryOpening <- fetch (get #libraryOpeningId reservation)
                    render EditView { .. }
                Right reservation -> do
                    reservation <- reservation |> updateRecord
                    setSuccessMessage "Reservation updated"
                    redirectTo EditReservationAction { .. }

    action CreateReservationAction = do
        let reservation = newRecord @Reservation
        reservation
            |> buildReservation
            |> validateStudentIdentifier
            |> ifValid \case
                Left reservation -> do
                    libraryOpening <- fetch (get #libraryOpeningId reservation)
                    library <- fetch (get #libraryId libraryOpening)
                    render NewView { .. }
                Right reservation -> do
                    reservation <- reservation
                        |> set #status Queued
                        |> createRecord

                    -- Create a Job for the Reservation to be processed.
                    newRecord @ReservationJob
                        |> set #reservationId (get #id reservation)
                        |> create

                    setSuccessMessage "Reservation request registered"
                    redirectTo $ ShowLibraryOpeningAction (get #libraryOpeningId reservation)

    action DeleteReservationAction { reservationId } = do
        reservation <- fetch reservationId
        deleteRecord reservation
        setSuccessMessage "Reservation deleted"
        redirectTo $ ShowLibraryOpeningAction (get #libraryOpeningId reservation)

buildReservation reservation = reservation
    |> fill @["libraryOpeningId","seatNumber","studentIdentifier"]

validateStudentIdentifier reservation =
    if isLeft (studentIdentifierResult $ get #studentIdentifier reservation)
        then reservation |> attachFailure #studentIdentifier "Student ID is not valid"
        else reservation



studentIdentifierResult :: Text -> Either Text Text
studentIdentifierResult val =
    let
        rightVal = Right val
    in
    rightVal
        >>= (\val ->  if "0000" `isPrefixOf` val then Left "ID shorter than 3" else rightVal)
        >>= (\val -> if Data.Text.length val < 3 then Left "ID shorter than 3" else rightVal)