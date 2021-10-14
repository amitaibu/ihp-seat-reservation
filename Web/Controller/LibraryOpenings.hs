module Web.Controller.LibraryOpenings where

import Web.Controller.Prelude
import Web.View.LibraryOpenings.Index
import Web.View.LibraryOpenings.New
import Web.View.LibraryOpenings.Edit
import Web.View.LibraryOpenings.Show

instance Controller LibraryOpeningsController where
    action LibraryOpeningsAction = do
        libraryOpenings <- query @LibraryOpening |> fetch
        render IndexView { .. }

    action NewLibraryOpeningAction = do
        let libraryOpening = newRecord
        render NewView { .. }

    action ShowLibraryOpeningAction { libraryOpeningId } = do
        libraryOpening <- fetch libraryOpeningId
        render ShowView { .. }

    action EditLibraryOpeningAction { libraryOpeningId } = do
        libraryOpening <- fetch libraryOpeningId
        render EditView { .. }

    action UpdateLibraryOpeningAction { libraryOpeningId } = do
        libraryOpening <- fetch libraryOpeningId
        libraryOpening
            |> buildLibraryOpening
            |> ifValid \case
                Left libraryOpening -> render EditView { .. }
                Right libraryOpening -> do
                    libraryOpening <- libraryOpening |> updateRecord
                    setSuccessMessage "LibraryOpening updated"
                    redirectTo EditLibraryOpeningAction { .. }

    action CreateLibraryOpeningAction = do
        let libraryOpening = newRecord @LibraryOpening
        libraryOpening
            |> buildLibraryOpening
            |> ifValid \case
                Left libraryOpening -> render NewView { .. } 
                Right libraryOpening -> do
                    libraryOpening <- libraryOpening |> createRecord
                    setSuccessMessage "LibraryOpening created"
                    redirectTo LibraryOpeningsAction

    action DeleteLibraryOpeningAction { libraryOpeningId } = do
        libraryOpening <- fetch libraryOpeningId
        deleteRecord libraryOpening
        setSuccessMessage "LibraryOpening deleted"
        redirectTo LibraryOpeningsAction

buildLibraryOpening libraryOpening = libraryOpening
    |> fill @["startTime","endTime","libraryId"]
