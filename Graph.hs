{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE FlexibleContexts #-}

module Graph where

import Control.Monad ( join )
import Data.List ( find, (\\), nub, intersect, sortBy, sortOn )
import Data.Maybe ( catMaybes, fromJust )
import qualified GHC.Types
import Data.Function (on)
import Data.Ord (comparing)


newtype Uedge a = Ue (a,a) deriving Show

(<->) :: a -> a -> Uedge a
(<->) a b = Ue (a,b)

instance Eq a => Eq (Uedge a) where
  (==) (Ue (a,b)) (Ue (a1,b1)) = a == a1 &&  b==b1 || a==b1 && b==a1

newtype Graph a = G [Uedge a] deriving Show

vertices :: Eq a => Graph a -> [a]
vertices (G l) = nub.join $ [ [a,b] | (Ue (a,b)) <- l]

opAdj :: Eq a => Uedge a -> a -> Maybe a
opAdj (Ue (a,b)) x | a == x = Just b
                    | b == x = Just a
                    | otherwise = Nothing


adj :: Eq a => Graph a -> a -> [a]
adj (G l) a = catMaybes [opAdj e a | e <- l]
