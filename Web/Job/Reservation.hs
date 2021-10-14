module Web.Job.Reservation where
import Web.Controller.Prelude

instance Job ReservationJob where
    perform ReservationJob { .. } = do
        putStrLn "Hello World!"
