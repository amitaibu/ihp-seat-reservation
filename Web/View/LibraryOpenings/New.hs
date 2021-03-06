module Web.View.LibraryOpenings.New where
import Web.View.Prelude

data NewView = NewView
    { libraryOpening :: LibraryOpening
    , library :: Library
    }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ShowLibraryAction (get #id library)}>{get #title library}</a></li>
                <li class="breadcrumb-item active">New Library Opening</li>
            </ol>
        </nav>
        <h1>New LibraryOpening</h1>
        {renderForm libraryOpening}
    |]


renderForm :: LibraryOpening -> Html
renderForm libraryOpening = formFor libraryOpening [hsx|
    {(dateTimeField #startTime)}
    {(dateTimeField #endTime)}
    {(hiddenField #libraryId)}
    {submitButton}
|]




