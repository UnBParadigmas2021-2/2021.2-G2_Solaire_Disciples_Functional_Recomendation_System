{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE QuasiQuotes #-}

import Recomendation
import RecomendationInfluence
import Graph
import Identification
import NetworkExamples
import Web.Scotty
import Text.Hamlet (shamlet)
import Text.Blaze.Html.Renderer.String (renderHtml)
import Text.Blaze.Renderer.Utf8 (renderMarkup)


render = raw . renderMarkup

data Person = Person
    { name :: String
    , _id  :: Int
    }


main = scotty 3000 $ do
  get "/" $ do
    render [shamlet|
      <p>Meu nome: #{name person}<p>
      <p>Meu Id:#{show $ _id person}<p>
    |]
  where
    person = Person (findPeopleById 1) (1)