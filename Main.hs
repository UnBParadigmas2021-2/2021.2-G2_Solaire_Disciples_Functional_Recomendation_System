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
      <head>
        <h1.h> Recomendation System
      <body>
        <p>Nome: #{name person}
        <p>Id:#{show $ _id person}
        
        <p>Lista de amigos:
          <ul>
            $forall friend <- friends
              <li>#{friend}

        <p>Recomendacao de amigos:
          <ul>
            $forall friend <- recomend_friends
              <li>#{friend}
    |]
  where
    person = Person (findPeopleById 1) (1)
    recomend_friends = getAllRecomendationsString (generateRecomendations g 1)
    friends = getAllFriendsString(getFriends g 1)
