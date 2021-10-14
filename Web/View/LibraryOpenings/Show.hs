module Web.View.LibraryOpenings.Show where
import Web.View.Prelude

data ShowView = ShowView
    { libraryOpening :: LibraryOpening
    , library :: Library
    , reservations :: [ Reservation ]
    }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={ShowLibraryAction (get #id library)}>{get #title library}</a></li>
                <li class="breadcrumb-item active">Show Library Opening</li>
            </ol>
        </nav>
        <h1>Library Opening for {get #title library}</h1>
        <div>{get #startTime libraryOpening |> dateTime} - {get #endTime libraryOpening |> dateTime}</div>

        {renderReservations libraryOpening reservations}
    |]


renderReservations libraryOpening reservations =
    [hsx|
        <h2>Reservations</h2>
        <div>
            <a href={pathTo $ NewReservationAction (get #id libraryOpening) } class="btn btn-primary mb-4">+ New Reservation</a>
        </div>

        {content}
    |]
    where
        content =
            if null reservations
                then [hsx|No Reservations|]
                else renderReservationsTable libraryOpening reservations

renderReservationsTable libraryOpening reservations = [hsx|
        <table class="table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Seat number</th>
                    <th>Student ID</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                {forEachWithIndex reservations (renderReservation (length reservations))}
            </tbody>
        </table>

    |]




renderReservation totalReservations (index, reservation) = [hsx|
        <tr>
            <td>{totalReservations - index}</td>
            <td>Seat {get #seatNumber reservation}</td>
            <td>{get #studentIdentifier reservation}</td>
            <td>{get #status reservation}</td>
        </tr>


    |]