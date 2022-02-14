{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}

import Recomendation
import RecomendationInfluence
import Graph
import Identification
import NetworkExamples
import Web.Scotty

main = scotty 3000 $ do
  get "/" $ do
    html "<h1>Hello World, lets build a recomendation system</h1>"
