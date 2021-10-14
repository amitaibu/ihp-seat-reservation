module Web.View.SeatCategories.New where

import Web.View.Prelude

data NewView = NewView {seatCategory :: SeatCategory}

instance View NewView where
    html NewView{..} =
        [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={SeatCategoriesAction (get #libraryId seatCategory)}>SeatCategories</a></li>
                <li class="breadcrumb-item active">New SeatCategory</li>
            </ol>
        </nav>
        <h1>New SeatCategory</h1>
        {renderForm seatCategory}
    |]

renderForm :: SeatCategory -> Html
renderForm seatCategory =
    formFor
        seatCategory
        [hsx|
    {(textField #title)}
    {(textField #fromNumber)}
    {(textField #toNumber)}
    {submitButton}
|]
