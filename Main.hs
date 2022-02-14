{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}

import Recomendation
import RecomendationInfluence
import Graph
import Identification
import NetworkExamples
import Web.Scotty ( get, html, scotty )
import qualified Data.Text as T
import Data.Monoid (mconcat)
import Data.Text.Lazy ( pack )



main = scotty 3000 $
  get "/" $
  html (pack "<h1>Ola, " <> pack (concat (getAllRecomendationsString [(2,1),(3,4)])))