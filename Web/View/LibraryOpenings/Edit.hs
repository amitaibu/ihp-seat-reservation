module Web.View.LibraryOpenings.Edit where
import Web.View.Prelude

data EditView = EditView { libraryOpening :: LibraryOpening }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={LibraryOpeningsAction}>LibraryOpenings</a></li>
                <li class="breadcrumb-item active">Edit LibraryOpening</li>
            </ol>
        </nav>
        <h1>Edit LibraryOpening</h1>
        {renderForm libraryOpening}
    |]

renderForm :: LibraryOpening -> Html
renderForm libraryOpening = formFor libraryOpening [hsx|
    {(textField #startTime)}
    {(textField #endTime)}
    {(textField #libraryId)}
    {submitButton}
|]
