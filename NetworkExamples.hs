{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE FlexibleContexts #-}

module NetworkExamples where

import Graph
import qualified Data.Map as Map
import Data.Map (Map)
import qualified Data.Maybe

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

network02 :: Graph Int
network02 = G [Ue (1, 2)
              ,Ue (2,3)
              ,Ue (7,1)
              ,Ue (2,8)
              ,Ue (8,3)
              ,Ue (1,9)
              ,Ue (3,7)]

network03 :: Graph Int
network03 = G [Ue (1, 2)
              ,Ue (1, 5)
              ,Ue (1,6)
              ,Ue (6,17)
              ,Ue (2,3)
              ,Ue (3,7)
              ,Ue (3,10)
              ,Ue (5,8)
              ,Ue (5,10)
              ,Ue (8,10)
              ,Ue (8,14)
              ,Ue (14,12)
              ,Ue (12,11)
              ,Ue (12,10)
              ,Ue (11,10)
              ,Ue (11,9)
              ,Ue (11,7)
              ,Ue (7,10)]
 
exampleMap :: Map Integer (Graph Int)
exampleMap = Map.fromList [(1,network01), (2,network02), (3,network03)]

findGraphById :: Integer -> Graph Int
findGraphById id = case Map.lookup id exampleMap of
                 Nothing  -> findGraphById (id -1)
                 Just graph -> graph


imageMap :: Map Integer [Char]
imageMap = Map.fromList [(1,"https://raw.githubusercontent.com/UnBParadigmas2021-2/2021.2-G2_Solaire_Disciples_Functional_Recomendation_System/master/NetworkExamplesImages/Network01.jpg")
                        , (2,"https://raw.githubusercontent.com/UnBParadigmas2021-2/2021.2-G2_Solaire_Disciples_Functional_Recomendation_System/master/NetworkExamplesImages/Network02.jpg")
                        , (3,"https://raw.githubusercontent.com/UnBParadigmas2021-2/2021.2-G2_Solaire_Disciples_Functional_Recomendation_System/master/NetworkExamplesImages/Network03.jpg")]


getGraphImage :: Integer -> [Char]
getGraphImage id = Data.Maybe.fromMaybe "" (Map.lookup id imageMap)