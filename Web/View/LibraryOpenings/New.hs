module Web.View.LibraryOpenings.New where
import Web.View.Prelude

data NewView = NewView { libraryOpening :: LibraryOpening }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={LibraryOpeningsAction}>LibraryOpenings</a></li>
                <li class="breadcrumb-item active">New LibraryOpening</li>
            </ol>
        </nav>
        <h1>New LibraryOpening</h1>
        {renderForm libraryOpening}
    |]

renderForm :: LibraryOpening -> Html
renderForm libraryOpening = formFor libraryOpening [hsx|
    {(textField #startTime)}
    {(textField #endTime)}
    {(textField #libraryId)}
    {submitButton}
|]
