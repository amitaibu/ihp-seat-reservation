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
import Application.Script.Prelude (JobStatus(JobStatusNotStarted))
import IHP.MailPrelude (JobStatus(JobStatusSucceeded))
import Web.Job.Reservation

tests :: Spec
tests = aroundAll (withIHPApp WebApplication config) do
        describe "ReservationsController" $ do
            it "has no existing reservations" $ withContext do
                count <- query @Reservation |> fetchCount
                count `shouldBe` 0

            it "has no existing reservations jobs" $ withContext do
                count <- query @ReservationJob |> fetchCount
                count `shouldBe` 0

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

                let libraryOpeningId = cs $ tshow $ get #id libraryOpening

                let params =
                        [ ("studentIdentifier", "1234")
                        , ("libraryOpeningId", libraryOpeningId)
                        ]

                response <- callActionWithParams CreateReservationAction params

                -- Only one Reservation and Reservation Job should exist.
                count <- query @Reservation |> fetchCount
                count `shouldBe` 1

                count <- query @ReservationJob |> fetchCount
                count `shouldBe` 1

                reservationJob <- query @ReservationJob |> orderByDesc #createdAt |> fetchOne
                get #status reservationJob `shouldBe` JobStatusNotStarted

                -- Process job.
                let frameworkConfig = getFrameworkConfig ?context
                let ?context = frameworkConfig in perform reservationJob

                reservationJob <- fetch (get #id reservationJob)
                get #status reservationJob `shouldBe` JobStatusSucceeded


        it "accepts valid student identifiers" $ withContext do
            let ids =
                    [ "0012"
                    , "1245"
                    , "9999999"
                    ]
            forEach ids (\id -> studentIdentifierResult id `shouldBe` Right id)





