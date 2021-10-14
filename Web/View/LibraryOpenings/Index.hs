module Web.View.LibraryOpenings.Index where

import Web.View.Prelude

data IndexView = IndexView
    { libraryOpenings :: [LibraryOpening]
    , libraryId :: Id Library
    }

instance View IndexView where
    html IndexView{..} =
        [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={LibraryOpeningAction libraryId}>LibraryOpenings</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo $ NewLibraryOpeningAction libraryId} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>LibraryOpening</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach libraryOpenings renderLibraryOpening}</tbody>
            </table>
        </div>
    |]

renderLibraryOpening :: LibraryOpening -> Html
renderLibraryOpening libraryOpening =
    [hsx|
    <tr>
        <td>{libraryOpening}</td>
        <td><a href={ShowLibraryOpeningAction (get #id libraryOpening)}>Show</a></td>
        <td><a href={EditLibraryOpeningAction (get #id libraryOpening)} class="text-muted">Edit</a></td>
        <td><a href={DeleteLibraryOpeningAction (get #id libraryOpening)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
