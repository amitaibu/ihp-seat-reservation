module Web.Job.Reservation where

import Web.Controller.Prelude
import Control.Concurrent (forkIO, threadDelay)
import Web.Mail.Reservations.Confirmation
import Web.Controller.Reservations


instance Job ReservationJob where
    perform ReservationJob { .. } = do
        reservation <- fetch reservationId

        reservation
            |> validateStudentIdentifer
            |> ifValid \case
                Left reservation -> do

                    reservation <- reservation
                        |> set #status Rejected
                        |> updateRecord


                    pure ()
                Right bid -> do
                    reservation <-
                        reservation
                            |> set #status Accepted
                            |> updateRecord

                    -- Don't delay the job for sending an email.
                    forkIO $ sendMail ConfirmationMail{..}

                    pure ()

        pure ()

    maxAttempts = 1
