module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.SeatCategories
import Web.Controller.LibraryOpenings
import Web.Controller.Libraries

instance FrontController WebApplication where
    controllers =
        [ startPage LibrariesAction
        -- Generator Marker
        , parseRoute @SeatCategoriesController
        , parseRoute @LibraryOpeningsController
        , parseRoute @LibrariesController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
