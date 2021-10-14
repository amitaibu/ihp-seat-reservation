module Web.Mail.Reservations.Confirmation where
import Web.View.Prelude
import IHP.MailPrelude

data ConfirmationMail = ConfirmationMail { reservation :: Reservation }

instance BuildMail ConfirmationMail where
    subject = "Subject"
    to ConfirmationMail { .. } = Address { addressName = Just "Firstname Lastname", addressEmail = "fname.lname@example.com" }
    from = "hi@example.com"
    html ConfirmationMail { .. } = [hsx|
        Hello World
    |]
