module Test.Controller.ReservationsSpec where

import Network.HTTP.Types.Status

import IHP.Prelude
import IHP.QueryBuilder (query)
import IHP.Test.Mocking
import IHP.Fetch

import IHP.FrameworkConfig
import IHP.HaskellSupport
import Test.Hspec
import Config

import Generated.Types
import Web.Routes
import Web.Types
import Web.Controller.Reservations (studentIdentifierResult)
import Web.FrontController ()
import Network.Wai
import IHP.ControllerPrelude

tests :: Spec
tests = aroundAll (withIHPApp WebApplication config) do
        describe "ReservationsController" $ do

            it "creates two new reservations" $ withContext do
                -- Create Library.
                library <- newRecord @Library
                        |> set #title "Lib 1"
                        |> set #totalNumberOfSeats 3
                        |> create

                -- Create Library opening.
                libraryOpening <- newRecord @LibraryOpening
                        |> set #libraryId (get #id library)
                        |> create

                let libraryOpeningId = cs $ show $ get #id libraryOpening

                let params =
                        [ ("studentIdentifier", "1234")
                        , ("libraryOpeningId", libraryOpeningId)
                        ]

                response <- callActionWithParams CreateReservationAction params

                -- Only one Reservation should exist.
                count <- query @Reservation |> fetchCount
                count `shouldBe` 1

                -- Create a second Reservation.
                let secondParams =
                        [ ("studentIdentifier", "4567")
                        , ("libraryOpeningId", libraryOpeningId)
                        ]


                response <- callActionWithParams CreateReservationAction secondParams

                -- Only one Reservation should exist.
                count <- query @Reservation |> fetchCount
                count `shouldBe` 2

        it "accepts valid student identifiers" $ withContext do
            let ids =
                    [ "0012"
                    , "1245"
                    , "9999999"
                    ]
            forEach ids (\id -> studentIdentifierResult id `shouldBe` Right id)





