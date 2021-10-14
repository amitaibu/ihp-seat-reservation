module Web.View.Libraries.Edit where
import Web.View.Prelude

data EditView = EditView { library :: Library }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={LibrariesAction}>Libraries</a></li>
                <li class="breadcrumb-item active">Edit Library</li>
            </ol>
        </nav>
        <h1>Edit Library</h1>
        {renderForm library}
    |]

renderForm :: Library -> Html
renderForm library = formFor library [hsx|
    {(textField #title)}
    {(numberField #totalNumberOfSeats)}
    {submitButton}
|]
