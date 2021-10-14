module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data LibrariesController
    = LibrariesAction
    | NewLibraryAction
    | ShowLibraryAction { libraryId :: !(Id Library) }
    | CreateLibraryAction
    | EditLibraryAction { libraryId :: !(Id Library) }
    | UpdateLibraryAction { libraryId :: !(Id Library) }
    | DeleteLibraryAction { libraryId :: !(Id Library) }
    deriving (Eq, Show, Data)

data LibraryOpeningsController
    = LibraryOpeningAction { libraryId :: !(Id Library) }
    | NewLibraryOpeningAction { libraryId :: !(Id Library) }
    | ShowLibraryOpeningAction { libraryOpeningId :: !(Id LibraryOpening) }
    | CreateLibraryOpeningAction
    | EditLibraryOpeningAction { libraryOpeningId :: !(Id LibraryOpening) }
    | UpdateLibraryOpeningAction { libraryOpeningId :: !(Id LibraryOpening) }
    | DeleteLibraryOpeningAction { libraryOpeningId :: !(Id LibraryOpening) }
    deriving (Eq, Show, Data)

data SeatCategoriesController
    = SeatCategoriesAction { libraryId :: !(Id Library) }
    | NewSeatCategoryAction { libraryId :: !(Id Library) }
    | ShowSeatCategoryAction { seatCategoryId :: !(Id SeatCategory) }
    | CreateSeatCategoryAction
    | EditSeatCategoryAction { seatCategoryId :: !(Id SeatCategory) }
    | UpdateSeatCategoryAction { seatCategoryId :: !(Id SeatCategory) }
    | DeleteSeatCategoryAction { seatCategoryId :: !(Id SeatCategory) }
    deriving (Eq, Show, Data)
