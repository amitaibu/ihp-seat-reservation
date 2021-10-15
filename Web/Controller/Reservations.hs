module Web.Controller.Reservations where

import Web.Controller.Prelude
import Web.View.Reservations.Index
import Web.View.Reservations.New
import Web.View.Reservations.Edit
import Web.View.Reservations.Show
import Web.Mail.Reservations.Confirmation

instance Controller ReservationsController where
    action ReservationsAction {..} = do
        reservations <- query @Reservation |> fetch
        libraryOpening <- fetch libraryOpeningId
        render IndexView { .. }

    action NewReservationAction {..} = do
        let reservation = newRecord |> set #libraryOpeningId libraryOpeningId
        libraryOpening <- fetch libraryOpeningId
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
            |> validateStudentIdentifer
            |> ifValid \case
                Left reservation -> do
                    libraryOpening <- fetch (get #libraryOpeningId reservation)
                    render NewView { .. }
                Right reservation -> do
                    reservation <- reservation
                        -- Indicate it's not in the queue yet.
                        |> set #status PreQueue
                        |> createRecord

                    -- Create a Job for the Reservation to be processed.
                    newRecord @ReservationJob |> create

                    setSuccessMessage "Reservation request registered"
                    redirectTo $ ShowLibraryOpeningAction (get #libraryOpeningId reservation)

    action DeleteReservationAction { reservationId } = do
        reservation <- fetch reservationId
        deleteRecord reservation
        setSuccessMessage "Reservation deleted"
        redirectTo $ ReservationsAction (get #libraryOpeningId reservation)

buildReservation reservation = reservation
    |> fill @["libraryOpeningId","seatNumber","studentIdentifier"]

validateStudentIdentifer reservation =
    if "0000" `isPrefixOf` get #studentIdentifier reservation
        then reservation |> attachFailure #studentIdentifier "Student ID is not valid"
        else reservation


