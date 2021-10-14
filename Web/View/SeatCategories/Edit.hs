module Web.View.SeatCategories.Edit where
import Web.View.Prelude

data EditView = EditView { seatCategory :: SeatCategory }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={SeatCategoriesAction (get #libraryId seatCategory)}>SeatCategories</a></li>
                <li class="breadcrumb-item active">Edit SeatCategory</li>
            </ol>
        </nav>
        <h1>Edit SeatCategory</h1>
        {renderForm seatCategory}
    |]

renderForm :: SeatCategory -> Html
renderForm seatCategory = formFor seatCategory [hsx|
    {(textField #title)}
    {(textField #fromNumber)}
    {(textField #toNumber)}
    {submitButton}
|]
