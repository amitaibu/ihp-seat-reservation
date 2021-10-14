module Web.View.SeatCategories.Index where

import Web.View.Prelude

data IndexView = IndexView
    { seatCategories :: [SeatCategory]
    , libraryId :: Id Library
    }

instance View IndexView where
    html IndexView{..} =
        [hsx|

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
renderSeatCategory seatCategory =
    [hsx|
    <tr>
        <td>{seatCategory}</td>
        <td><a href={ShowSeatCategoryAction (get #id seatCategory)}>Show</a></td>
        <td><a href={EditSeatCategoryAction (get #id seatCategory)} class="text-muted">Edit</a></td>
        <td><a href={DeleteSeatCategoryAction (get #id seatCategory)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
