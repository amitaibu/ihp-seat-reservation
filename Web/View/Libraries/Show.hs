module Web.View.Libraries.Show where
import Web.View.Prelude

data ShowView = ShowView
    { library :: Library
    , libraryOpenings :: [LibraryOpening]
    }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={LibrariesAction}>Libraries</a></li>
                <li class="breadcrumb-item active">Show Library</li>
            </ol>
        </nav>
        <h1>{get #title library}</h1>

        {renderLibraryOpenings library libraryOpenings}

    |]


renderLibraryOpenings library libraryOpenings = [hsx|
        <h2>Library Openings</h2>
        <div>
            <a href={pathTo $ NewLibraryOpeningAction (get #id library) } class="btn btn-primary">+ New</a>
        </div>


        <table class="table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Ops</th>
                </tr>
            </thead>
            <tbody>
                {forEachWithIndex libraryOpenings renderLibraryOpening}
            </tbody>
        </table>



    |]


renderLibraryOpening (index, libraryOpening) = [hsx|
        <tr>
            <td>{index + 1}</td>
            <td>{get #startTime libraryOpening |> dateTime}</td>
            <td>{get #endTime libraryOpening |> dateTime}</td>
            <td><a href={ShowLibraryOpeningAction (get #id libraryOpening)}>Show</a></td>
        </tr>


    |]