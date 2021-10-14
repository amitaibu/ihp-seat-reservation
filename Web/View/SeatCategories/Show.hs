module Web.View.SeatCategories.Show where
import Web.View.Prelude

data ShowView = ShowView { seatCategory :: SeatCategory }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={SeatCategoriesAction (get #libraryId seatCategory)}>SeatCategories</a></li>
                <li class="breadcrumb-item active">Show SeatCategory</li>
            </ol>
        </nav>
        <h1>Show SeatCategory</h1>
        <p>{seatCategory}</p>
    |]
