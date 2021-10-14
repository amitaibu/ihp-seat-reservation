module Web.View.LibraryOpenings.Show where
import Web.View.Prelude

data ShowView = ShowView { libraryOpening :: LibraryOpening }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">

                <li class="breadcrumb-item active">Show LibraryOpening</li>
            </ol>
        </nav>
        <h1>Show LibraryOpening</h1>
        <p>{libraryOpening}</p>
    |]
