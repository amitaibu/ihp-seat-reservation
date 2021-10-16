module Web.View.Reservations.New where
import Web.View.Prelude

data NewView = NewView
    { reservation :: Reservation
    , libraryOpening :: LibraryOpening
    , library :: Library
    }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ShowLibraryOpeningAction (get #id libraryOpening)}>Library opening for {get #title library}</a></li>
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
