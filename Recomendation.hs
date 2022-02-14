{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}

module Recomendation where

import Graph
import Control.Monad ( join )
import Data.List ( find, (\\), nub, intersect, sortBy, sortOn )
import Data.Maybe ( catMaybes, fromJust )
import qualified GHC.Types
import Data.Function (on)
import Data.Ord (comparing)

-- amigo dos amigo
foaf :: Eq a => Graph a -> a -> [a]
foaf g a = nub(join(map (getFriends g) (getFriends g a))) \\ getIgnoredElements g a

-- Retorna lista de elementos a serem ignorados
-- No caso, retorna lista com o elemento 'a' (inicial) e os amigos de 'a'
getIgnoredElements :: Eq a => Graph a -> a -> [a]
getIgnoredElements g a = a : getFriends g a

-- Retorna amigos do elemento 'a'
getFriends :: Eq a => Graph a -> a -> [a]
getFriends = adj

-- Retorna amigos em comum entre elemento 'a' e 'b'
getCommonFriends :: Eq a => Graph a -> a -> a -> [a]
getCommonFriends g a b = getFriends g a `intersect` getFriends g b

-- Concatena duas listas sem inserir duplicatas
concatList:: [Int] -> [Int] -> [Int]
concatList x y = nub (x ++ y)

-- TODO -> Recommend by influence -> substituir o length (que considera cada amigo como 1)
-- por um sistema que penaliza o score baseado em quantos amigos cada item de getCommonFriends tem (n). -> 1/n1 + 1/n2 + 1/n3 ...
-- exemplo: https://courses.cs.washington.edu/courses/cse140/13wi/homework/hw4/homework4.html problem 3

-- Conta quantos amigos tem 'a'
countFriends :: Eq a => Graph a -> a -> Int
countFriends g a = length( getFriends g a)

-- Conta quantos amigos o no 'a' tem em comum com o no 'b'
countCommonFriends :: Eq a => Graph a -> a -> a -> Int
countCommonFriends g a b = length(getCommonFriends g a b)

-- Transforma toda a lista de nó em (score, id)
addAllPeopleScore :: Eq b => Graph b -> b -> [b] -> [(Int, b)]
addAllPeopleScore g a list = map(addPeopleScore g a) list

-- Transforma um no em uma tupla sendo (score, id)
addPeopleScore :: Eq b => Graph b -> b -> b -> (Int, b)
addPeopleScore g a b = (countCommonFriends g a b, b)

-- Ordena nó por quantidade total de amigos em comum
sortByCommonFriends :: Ord b1 => [(b1, b2)] -> [(b1, b2)]
sortByCommonFriends a = reverse (sortOn fst a)

-- Retorna recomendação de amizades
generateRecomendations :: Eq a => Graph a -> a -> [(Int, a)]
generateRecomendations g a = sortByCommonFriends(addAllPeopleScore g a (foaf g a))
