module Web.Controller.Libraries where

import Web.Controller.Prelude
import Web.View.Libraries.Index
import Web.View.Libraries.New
import Web.View.Libraries.Edit
import Web.View.Libraries.Show

instance Controller LibrariesController where
    action LibrariesAction = do
        libraries <- query @Library |> fetch
        render IndexView { .. }

    action NewLibraryAction = do
        let library = newRecord
        render NewView { .. }

    action ShowLibraryAction { libraryId } = do
        library <- fetch libraryId

        libraryOpenings <- query @LibraryOpening
                            |> filterWhere (#libraryId, libraryId)
                            |> orderByDesc #startTime
                            |>fetch

        render ShowView { .. }

    action EditLibraryAction { libraryId } = do
        library <- fetch libraryId
        render EditView { .. }

    action UpdateLibraryAction { libraryId } = do
        library <- fetch libraryId
        library
            |> buildLibrary
            |> validateField #totalNumberOfSeats (isGreaterThan 0)
            |> ifValid \case
                Left library -> render EditView { .. }
                Right library -> do
                    library <- library |> updateRecord
                    setSuccessMessage "Library updated"
                    redirectTo EditLibraryAction { .. }

    action CreateLibraryAction = do
        let library = newRecord @Library
        library
            |> buildLibrary
            |> validateField #totalNumberOfSeats (isGreaterThan 0)
            |> ifValid \case
                Left library -> render NewView { .. }
                Right library -> do
                    library <- library |> createRecord
                    setSuccessMessage "Library created"
                    redirectTo LibrariesAction

    action DeleteLibraryAction { libraryId } = do
        library <- fetch libraryId
        deleteRecord library
        setSuccessMessage "Library deleted"
        redirectTo LibrariesAction

buildLibrary library = library
    |> fill @'["title", "totalNumberOfSeats"]
