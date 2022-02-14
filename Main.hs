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


main :: IO ()
main = scotty 3000 $ do
  get "/:id" $ do
    beam <- param "id"
    render [shamlet|
      <style>
        span {display: inline-block; padding:0px 40px; border: 1px solid}

      <head>
        <h1.h> Recomendation System
      <body>
        <p>Nome: #{name person}
        <p>Id:#{show $ _id person}
        <p>Lista de amigos:
          <ol>
            $forall friend <- friends
              <li>#{friend}

        <span>
          <p>Recomendacao de amigos (padrao):
            <ol>
              $forall friend <- recomend_friends
                <li>#{friend}

        <span>
          <p>Recomendacao de amigos (influencia):
            <ol>
              $forall friend <- recomend_by_influence_friends
                <li>#{friend}
          
    |]
  where
    person = Person (findPeopleById 1) (1)
    recomend_friends = getAllRecomendationsString (generateRecomendations (findGraphById 1) 1)
    recomend_by_influence_friends = getAllRecomendatonInfluenceString(generateRecomendationsByInfluence (findGraphById 1) 1)
    friends = getAllFriendsString(getFriends (findGraphById 1) 1)
