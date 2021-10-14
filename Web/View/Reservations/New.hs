module Web.View.Reservations.New where
import Web.View.Prelude

data NewView = NewView
    { reservation :: Reservation
    , libraryOpening :: LibraryOpening
    }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ReservationsAction (get #id libraryOpening)}>Reservations</a></li>
                <li class="breadcrumb-item active">New Reservation</li>
            </ol>
        </nav>
        <h1>New Reservation</h1>
        {renderForm reservation}
    |]

renderForm :: Reservation -> Html
renderForm reservation = formFor reservation [hsx|
    {(hiddenField #libraryOpeningId)}
    {(textField #studentIdentifier) { required = True, helpText = "Enter a dummy Student ID. If it starts with 0000 it will be rejected.", fieldLabel ="Student ID" }}
    {submitButton}
|]
