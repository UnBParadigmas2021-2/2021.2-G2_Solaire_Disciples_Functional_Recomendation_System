{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE FlexibleContexts #-}

module NetworkExamples where

import Graph

network01 :: Graph Int
network01 = G [Ue (1,2)
              ,Ue (1,5)
              ,Ue (1,8)
              ,Ue (2,5)
              ,Ue (2,10)
              ,Ue (2,11)
              ,Ue (2,3)
              ,Ue (5,11)
              ,Ue (5,10)
              ,Ue (8,10)
              ,Ue (8,12)
              ,Ue (3,11)
              ,Ue (3,7)
              ,Ue (11,7)
              ,Ue (11,14)
              ,Ue (11,10)
              ,Ue (10,14)
              ,Ue (17,12)
              ,Ue (17,9)]