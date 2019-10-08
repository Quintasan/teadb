{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
module Main where

import GHC.Generics
import Web.Scotty
import Data.Aeson (FromJSON, ToJSON)
import Network.HTTP.Types

data Tea = Tea { teaId :: Int, name :: String } deriving (Show, Generic)
instance ToJSON Tea
instance FromJSON Tea

yunnan :: Tea
yunnan = Tea { teaId = 1, name = "Yunnan" }

earl_grey :: Tea
earl_grey = Tea { teaId = 2, name = "Earl Grey" }

main = do
  putStrLn "Starting TeaDB web server..."
  scotty 6666 $ do
    get "/" $ do
      status ok200
      text "Witaj w bazie danych herbat"

    get "/teas" $ do
      status ok200
      text "Nie ma żadnych herbat"

    post "/teas" $ do
      tea <- jsonData :: ActionM Tea
      status created201
      json tea
