{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ViewPatterns #-}

module Identification where

import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)

people :: Map Integer String 
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
findPeopleById :: Integer -> String
findPeopleById id = case Map.lookup id people of
                 Nothing  -> "Kage Bushin no Jutsu No. " ++ show id
                 Just name -> name

-- A função de recomendação retorna objetos contendo (score, id)
-- Essa função traduz o id para o nome
findPeopleByTuple :: (a, Integer) -> String
findPeopleByTuple tuple = findPeopleById (snd tuple)
