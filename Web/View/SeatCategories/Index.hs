module Web.View.SeatCategories.Index where
import Web.View.Prelude

data IndexView = IndexView { seatCategories :: [SeatCategory] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={SeatCategoriesAction (get #libraryId seatCategory)}>SeatCategories</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewSeatCategoryAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>SeatCategory</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach seatCategories renderSeatCategory}</tbody>
            </table>
        </div>
    |]


renderSeatCategory :: SeatCategory -> Html
renderSeatCategory seatCategory = [hsx|
    <tr>
        <td>{seatCategory}</td>
        <td><a href={ShowSeatCategoryAction (get #id seatCategory)}>Show</a></td>
        <td><a href={EditSeatCategoryAction (get #id seatCategory)} class="text-muted">Edit</a></td>
        <td><a href={DeleteSeatCategoryAction (get #id seatCategory)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
