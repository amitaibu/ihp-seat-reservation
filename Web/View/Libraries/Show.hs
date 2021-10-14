module Web.View.Libraries.Show where
import Web.View.Prelude

data ShowView = ShowView { library :: Library }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={LibrariesAction}>Libraries</a></li>
                <li class="breadcrumb-item active">Show Library</li>
            </ol>
        </nav>
        <h1>Show Library</h1>
        <p>{library}</p>
    |]
