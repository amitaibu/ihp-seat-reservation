module Web.View.Libraries.Index where
import Web.View.Prelude

data IndexView = IndexView { libraries :: [Library] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={LibrariesAction}>Libraries</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewLibraryAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Library</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach libraries renderLibrary}</tbody>
            </table>
        </div>
    |]


renderLibrary :: Library -> Html
renderLibrary library = [hsx|
    <tr>
        <td>{get #title library}</td>
        <td><a href={ShowLibraryAction (get #id library)}>Show</a></td>
        <td><a href={EditLibraryAction (get #id library)} class="text-muted">Edit</a></td>
        <td><a href={DeleteLibraryAction (get #id library)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
