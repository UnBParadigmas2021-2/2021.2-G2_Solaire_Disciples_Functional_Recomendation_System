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
import Text.Blaze.Html4.FrameSet.Attributes (background)


render = raw . renderMarkup

data Person = Person
    { name :: String
    , _id  :: Int
    }


main :: IO ()
main = scotty 3000 $ do
  get "/" $ do
    render [shamlet|
      <style>
        span {
          display: inline-block; padding:0px 40px; border: 1px solid
          height: 300px;  
          align: top;
        }
        body {
          background-color: #9fc3fc;
          font-family: monospace;
          center-align: center;
          align-items: center;
          justify-content: center;
        }
        .li-friend {
          height: 100px;
          max-height: 100px;
          font-size: 18px;
        }
        .center {
          text-align: center;
        }
        .blue-border {
          border: 5px solid #6f87ad;
        }
        .friend {
          padding: 5px;
          margin-bottom: 5px;
          width: 300px;
          wrap: break-around;
          text-align: left;
        }
        .friend:hover {
          background-color: #FFFFFF;
        }
        .fix-space {
          margin: 0px;
        }
        .image {
          width: 800px;
          height: 600px;
          position: absolute;
          right: 0%;
          top: 0%;
        }
        .title {
          font-size: 22px;
        }
        .subtitle {
          font-size: 14px;
        }

      <head>
        <h1.h> Recomendation System
      <body>
        <h3 class="center blue-border">Nome: #{name person}
        <p class="center">Id:#{show $ _id person}
        <p class="center">Lista de amigos:
          <ol class="center">
            $forall friend <- friends
              <li>#{friend}

        <span class="center">
          <p class="title">Recomendacao de amigos (padrao):
            <ol>
              $forall friend <- recomend_friends
                <li class="li-friend">
                  <div class="friend">
                    <h4 class="fix-space">#{fst friend}
                    <p class="fix-space subtitle">#{snd friend}

        <span class="center">
          <p class="title">Recomendacao de amigos (influencia):
            <ol>
              $forall friend <- recomend_by_influence_friends
                <li class="li-friend">
                  <div class="friend">
                    <h4 class="fix-space">#{fst friend}
                    <p class="fix-space subtitle">#{snd friend}
        <img class="image" src=#{graph_image}>
    |]
  where
    person_id = 1
    graph_id = 1
    person = Person (findPeopleById person_id) (person_id)
    recomend_friends = getAllRecomendationsString (generateRecomendations (findGraphById graph_id) person_id)
    recomend_by_influence_friends = getAllRecomendatonInfluenceString(generateRecomendationsByInfluence (findGraphById graph_id) person_id)
    friends = getAllFriendsString(getFriends (findGraphById graph_id) person_id)
    graph_image = getGraphImage graph_id