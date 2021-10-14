module Web.View.Reservations.New where
import Web.View.Prelude

data NewView = NewView { reservation :: Reservation }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ReservationsAction}>Reservations</a></li>
                <li class="breadcrumb-item active">New Reservation</li>
            </ol>
        </nav>
        <h1>New Reservation</h1>
        {renderForm reservation}
    |]

renderForm :: Reservation -> Html
renderForm reservation = formFor reservation [hsx|
    {(textField #libraryOpeningId)}
    {(textField #seatNumber)}
    {(textField #studentIdentifier)}
    {submitButton}
|]
