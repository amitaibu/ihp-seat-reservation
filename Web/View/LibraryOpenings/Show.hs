module Web.View.LibraryOpenings.Show where
import Web.View.Prelude

data ShowView = ShowView
    { libraryOpening :: LibraryOpening
    , library :: Library
    }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">

                <li class="breadcrumb-item active">Show LibraryOpening</li>
            </ol>
        </nav>
        <h1>Library Opening for {get #title library}</h1>
        <div>{get #startTime libraryOpening |> dateTime} - {get #endTime libraryOpening |> dateTime}</div>
    |]
