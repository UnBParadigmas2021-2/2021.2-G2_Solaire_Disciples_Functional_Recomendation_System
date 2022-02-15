{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ViewPatterns #-}

module Identification where

import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)
import Control.Monad (join)
import Data.List (nub)
import qualified GHC.Types

people :: Map Int String
people = Map.fromList [(1, "Joao Pe de Feijao")
                      ,(2, "Maria Silva Sousa")
                      ,(3, "Pedro Marcos")
                      ,(4, "Felipe Homogeneo")
                      ,(5, "Giuseppe Cadura")
                      ,(6, "Guilherme Coelho")
                      ,(7, "Sheila Behringer")
                      ,(8, "Marcela Santos")
                      ,(9, "John Lennon")
                      ,(10, "Jade Picon")
                      ,(11, "Ednaldo Pereira")
                      ,(12, "Juliana Bonde")
                      ,(13, "Fabio de Melo")
                      ,(14, "Luan Santana")
                      ,(15, "Gustavo Lima")
                      ,(16, "Marilia Mendonca")
                      ,(17, "Linus Tech Tips")]

-- Encontra o nome relacionado ao id
-- Caso o id nao esteja na lista de nomes gerados, eh retornado um clone das sombras do naruto
findPeopleById :: Int -> String
findPeopleById id = case Map.lookup id people of
                 Nothing  -> "Kage Bushin no Jutsu No. " ++ show id
                 Just name -> name

-- A função de recomendação retorna objetos contendo (score, id)
-- Essa função traduz o id para o nome
findPeopleNameByTuple :: (a, Int) -> String
findPeopleNameByTuple tuple = findPeopleById (snd tuple)

peopleScoreToString :: (Int, a) -> String
peopleScoreToString tuple = "Possui " ++ show (fst tuple) ++ " amigos em comum com voce!"

peopleRecomendationToString :: (Int, Int) -> String
peopleRecomendationToString tuple = findPeopleNameByTuple tuple ++ "\n" ++ peopleScoreToString tuple ++ "\n"

peopleRecomendationTuple :: (Int, Int) -> (String, String)
peopleRecomendationTuple tuple = (findPeopleNameByTuple tuple, peopleScoreToString tuple)

printPeople :: (Int, Int) -> IO ()
printPeople tuple = putStrLn (peopleRecomendationToString tuple)


getAllRecomendationsString :: [(Int, Int)] -> [(String, String)]
getAllRecomendationsString recomendationList = map peopleRecomendationTuple recomendationList


peopleFriendToString :: Int -> [Char]
peopleFriendToString a = findPeopleById a ++ "\n"

getAllFriendsString :: [Int] -> [[Char]]
getAllFriendsString friendList = map peopleFriendToString friendList



getAllRecomendatonInfluenceString :: Show a => [(a, Int)] -> [(String, [Char])]
getAllRecomendatonInfluenceString recomendationList = map peopleRecomendationInfluenceToString recomendationList


peopleRecomendationInfluenceToString :: Show a => (a, Int) -> (String, [Char])
peopleRecomendationInfluenceToString tuple = (findPeopleNameByTuple tuple, peopleInfluenceScoreToString tuple)

peopleInfluenceScoreToString :: Show a => (a, b) -> [Char]
peopleInfluenceScoreToString tuple = "Possui " ++ show (fst tuple) ++ " de score de recomendacao com voce!"
