module Web.Mail.Reservations.Confirmation where

import Web.View.Prelude
import IHP.MailPrelude

data ConfirmationMail = ConfirmationMail
    { reservation :: Reservation
    , library :: Library
    }

instance BuildMail ConfirmationMail where
    subject = "Subject"
    to ConfirmationMail { .. } = Address { addressName = Just "Firstname Lastname", addressEmail = "fname.lname@example.com" }
    from = "hi@example.com"
    html ConfirmationMail { .. } = [hsx|
        Hello Student (#{get #studentIdentifier reservation}),

        Your reservation for library "{get #title library}" is now <strong>{get #status reservation}</strong>

        See <a href={ShowReservationAction (get #id reservation)}>Reservation</a>
    |]
