module Web.Controller.SeatCategories where

import Web.Controller.Prelude
import Web.View.SeatCategories.Edit
import Web.View.SeatCategories.Index
import Web.View.SeatCategories.New
import Web.View.SeatCategories.Show

instance Controller SeatCategoriesController where
    action SeatCategoriesAction{..} = do
        seatCategories <- query @SeatCategory |> filterWhere (#libraryId, libraryId) |> fetch
        render IndexView{..}
    action NewSeatCategoryAction{..} = do
        let seatCategory = newRecord |> set #libraryId libraryId
        render NewView{..}
    action ShowSeatCategoryAction{seatCategoryId} = do
        seatCategory <- fetch seatCategoryId
        render ShowView{..}
    action EditSeatCategoryAction{seatCategoryId} = do
        seatCategory <- fetch seatCategoryId
        render EditView{..}
    action UpdateSeatCategoryAction{seatCategoryId} = do
        seatCategory <- fetch seatCategoryId
        seatCategory
            |> buildSeatCategory
            |> ifValid \case
                Left seatCategory -> render EditView{..}
                Right seatCategory -> do
                    seatCategory <- seatCategory |> updateRecord
                    setSuccessMessage "SeatCategory updated"
                    redirectTo EditSeatCategoryAction{..}
    action CreateSeatCategoryAction = do
        let seatCategory = newRecord @SeatCategory
        seatCategory
            |> buildSeatCategory
            |> ifValid \case
                Left seatCategory -> render NewView{..}
                Right seatCategory -> do
                    seatCategory <- seatCategory |> createRecord
                    setSuccessMessage "SeatCategory created"
                    redirectTo $ SeatCategoriesAction $ get #libraryId seatCategory
    action DeleteSeatCategoryAction{seatCategoryId} = do
        seatCategory <- fetch seatCategoryId
        deleteRecord seatCategory
        setSuccessMessage "SeatCategory deleted"
        redirectTo $ SeatCategoriesAction $ get #libraryId seatCategory

buildSeatCategory seatCategory =
    seatCategory
        |> fill @["title", "fromNumber", "toNumber"]
