module Web.Controller.Reservations where

import Web.Controller.Prelude
import Web.View.Reservations.Index
import Web.View.Reservations.New
import Web.View.Reservations.Edit
import Web.View.Reservations.Show

instance Controller ReservationsController where
    action ReservationsAction = do
        reservations <- query @Reservation |> fetch
        render IndexView { .. }

    action NewReservationAction = do
        let reservation = newRecord
        render NewView { .. }

    action ShowReservationAction { reservationId } = do
        reservation <- fetch reservationId
        render ShowView { .. }

    action EditReservationAction { reservationId } = do
        reservation <- fetch reservationId
        render EditView { .. }

    action UpdateReservationAction { reservationId } = do
        reservation <- fetch reservationId
        reservation
            |> buildReservation
            |> ifValid \case
                Left reservation -> render EditView { .. }
                Right reservation -> do
                    reservation <- reservation |> updateRecord
                    setSuccessMessage "Reservation updated"
                    redirectTo EditReservationAction { .. }

    action CreateReservationAction = do
        let reservation = newRecord @Reservation
        reservation
            |> buildReservation
            |> ifValid \case
                Left reservation -> render NewView { .. } 
                Right reservation -> do
                    reservation <- reservation |> createRecord
                    setSuccessMessage "Reservation created"
                    redirectTo ReservationsAction

    action DeleteReservationAction { reservationId } = do
        reservation <- fetch reservationId
        deleteRecord reservation
        setSuccessMessage "Reservation deleted"
        redirectTo ReservationsAction

buildReservation reservation = reservation
    |> fill @["libraryOpeningId","seatNumber","studentIdentifier"]
