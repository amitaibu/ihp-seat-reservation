module Web.Controller.LibraryOpenings where

import Web.Controller.Prelude
import Web.View.LibraryOpenings.Edit
import Web.View.LibraryOpenings.Index
import Web.View.LibraryOpenings.New
import Web.View.LibraryOpenings.Show

instance Controller LibraryOpeningsController where
    action LibraryOpeningAction{..} = do
        libraryOpenings <- query @LibraryOpening |> filterWhere (#libraryId, libraryId) |> fetch
        render IndexView{..}

    action NewLibraryOpeningAction{..} = do
        current <- getCurrentTime
        let libraryOpening = newRecord
                |> set #libraryId libraryId
                |> set #startTime current
                -- Add one hour.
                |> set #endTime (addUTCTime (secondsToNominalDiffTime $ 60 * 60) current)

        library <- fetch libraryId
        render NewView{..}

    action ShowLibraryOpeningAction{libraryOpeningId} = do
        libraryOpening <- fetch libraryOpeningId
        library <- fetch (get #libraryId libraryOpening)
        reservations <- query @Reservation
                |> filterWhere (#libraryOpeningId, libraryOpeningId)
                |> orderByDesc #createdAt
                |> fetch
        render ShowView{..}

    action EditLibraryOpeningAction{libraryOpeningId} = do
        libraryOpening <- fetch libraryOpeningId
        render EditView{..}

    action UpdateLibraryOpeningAction{libraryOpeningId} = do
        libraryOpening <- fetch libraryOpeningId
        libraryOpening
            |> buildLibraryOpening
            |> ifValid \case
                Left libraryOpening -> render EditView{..}
                Right libraryOpening -> do
                    libraryOpening <- libraryOpening |> updateRecord
                    setSuccessMessage "LibraryOpening updated"
                    redirectTo EditLibraryOpeningAction{..}

    action CreateLibraryOpeningAction = do
        let libraryOpening = newRecord @LibraryOpening
        libraryOpening
            |> buildLibraryOpening
            |> ifValid \case
                Left libraryOpening -> do
                    library <- fetch (get #libraryId libraryOpening)
                    render NewView{..}
                Right libraryOpening -> do
                    libraryOpening <- libraryOpening |> createRecord
                    setSuccessMessage "LibraryOpening created"
                    redirectTo LibrariesAction

    action DeleteLibraryOpeningAction{libraryOpeningId} = do
        libraryOpening <- fetch libraryOpeningId
        deleteRecord libraryOpening
        setSuccessMessage "LibraryOpening deleted"
        redirectTo LibrariesAction

buildLibraryOpening libraryOpening =
    libraryOpening
        |> fill @["startTime", "endTime", "libraryId"]
