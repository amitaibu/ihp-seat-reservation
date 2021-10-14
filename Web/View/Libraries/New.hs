module Web.View.Libraries.New where
import Web.View.Prelude

data NewView = NewView { library :: Library }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={LibrariesAction}>Libraries</a></li>
                <li class="breadcrumb-item active">New Library</li>
            </ol>
        </nav>
        <h1>New Library</h1>
        {renderForm library}
    |]

renderForm :: Library -> Html
renderForm library = formFor library [hsx|
    {(textField #title)}
    {submitButton}
|]
