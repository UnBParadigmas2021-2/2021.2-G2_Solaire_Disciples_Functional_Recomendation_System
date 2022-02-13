{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE FlexibleContexts #-}

module RecomendationInfluence where

import Graph
import Control.Monad ( join )
import Data.List ( find, (\\), nub, intersect, sortBy, sortOn )
import Data.Maybe ( catMaybes, fromJust )
import qualified GHC.Types
import Data.Function (on)
import Data.Ord (comparing)
import Recomendation ( getCommonFriends, countFriends, sortByCommonFriends, foaf )

-- Calcula o score levando em conta a quantidade de amigos que o(s) amigo(s) em comum entre 'a' e 'b' tem
getFriendScoreByInfluence :: (Fractional a1, Eq a2) => Graph a2 -> a2 -> a2 -> a1
getFriendScoreByInfluence g a b = sum(map (1/) (map fromIntegral (map (countFriends g) (getCommonFriends g a b))))

-- Transforma toda a lista de no em (score, id)
addAllPeopleScoreByInfluence :: (Fractional a, Eq b) => Graph b -> b -> [b] -> [(a, b)]
addAllPeopleScoreByInfluence g a list = map(addPeopleScoreByInfluence g a) list

-- Transforma um no em uma tupla sendo (score, id)
addPeopleScoreByInfluence :: (Fractional a, Eq b) => Graph b -> b -> b -> (a, b)
addPeopleScoreByInfluence g a b = (getFriendScoreByInfluence g a b, b)

-- Retorna recomendacao de amizades por influencia
generateRecomendationsByInfluence :: (Ord b1, Fractional b1, Eq b2) => Graph b2 -> b2 -> [(b1, b2)]
generateRecomendationsByInfluence g a = sortByCommonFriends(addAllPeopleScoreByInfluence g a (foaf g a))
