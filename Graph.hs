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

-- addNodeInGraph :: (Graph a -> Graph a -> t) -> a -> a -> t
-- addNodeInGraph g a b = g ++ G[(newNode a b)]

newNode :: a -> a -> Uedge a
newNode a b = Ue(a, b)

g :: Graph Int
g = G [Ue (1, 2), Ue (2,3) , Ue (7,1),Ue (2,8),Ue (8,3),Ue (1,9),Ue (3,7)]

add :: Graph a -> Uedge a -> Graph a
add (G l) e = G $ e:l


add_node :: Graph a -> a -> a -> Graph a
add_node g n b = add g $ Ue (n,b)

vertices :: Eq a => Graph a -> [a]
vertices (G l) = nub.join $ [ [a,b] | (Ue (a,b)) <- l]

opAdj :: Eq a => Uedge a -> a -> Maybe a
opAdj (Ue (a,b)) x | a == x = Just b
                    | b == x = Just a
                    | otherwise = Nothing


adj :: Eq a => Graph a -> a -> [a]
adj (G l) a = catMaybes [opAdj e a | e <- l]

isAdj :: Eq a => Graph a -> a -> a -> Bool
isAdj (G l) a b = Ue (a,b) `elem` l

isWalk :: Eq a => Graph a -> [a] -> Bool
isWalk _ [] = True
isWalk _ [a] = True
isWalk g (x:y:xs) = isAdj g x y && isWalk g (y:xs)

connectNearestUe :: [a] -> [Uedge a]
connectNearestUe [] = []
connectNearestUe [a] = []
connectNearestUe (x:y:xs) = Ue (x,y):connectNearestUe (y:xs)

isTrail :: Eq a => Graph a -> [a] -> Bool
isTrail g l = isWalk g l && length alle == (length.nub $ alle) where alle = connectNearestUe l

isPath :: Eq a => Graph a -> [a] -> Bool
isPath g l = isWalk g l && length l == (length.nub $ l)

open :: Eq a => Graph a -> [a] -> Bool
open _ [] = True
open _ [a] = True
open g l = head l /= last l && null (l \\ vertices g)


close :: Eq a => Graph a -> [a] -> Bool
close g l = not $ open g l

paths :: Eq a => Graph a -> [a] -> a -> a -> [[a]]
paths g v a b | a == b = [[a]]
              | a /= b = (b:) <$> concat (paths g (v++[b]) a <$> adj g b \\ v)

step_ :: Eq a => Graph a -> ([a], [a]) -> ([a], [a])
step_ _ (v,[]) = (v,[])
step_ g (v,h:q) = (v++[h], ((adj g h \\ v) \\ q) ++ q )

dfs :: Eq a => Graph a -> a -> [a]
dfs g a = fst $ fromJust $ find (\(_,q)->null q) $ iterate (step_ g) ([],[a])

bfs :: Eq a => Graph a -> [a] -> [a] -> [a]
bfs _ _ [] = []
bfs g v (h:qs) = h : bfs g (h:v) (qs++((adj g h \\ v) \\ qs))


bfsl :: Eq a => Graph a -> a -> [(a, Int)]
bfsl g v = bfsL g [] ([(v,0) | elem v $ vertices g])
bfsL :: Eq a => Graph a -> [(a,Int)] -> [(a,Int)] -> [(a,Int)]
bfsL _ _ [] = []
bfsL g v ((h,l):qs) = (h,l) : bfsL g v1 (qs++a)
                                where
                                  v1 = (h,l):v
                                  a = add_l ((adj g h \\ au v) \\ au qs) (l+1)
                                  au l = [fst e | e <- l]
                                  add_l vs l = [ (v,l) | v <- vs ]

sPaths :: Eq a => Graph a -> a -> a -> Maybe [[a]]
sPaths g a b = do
                lookup a bfs
                lb <- lookup b bfs
                return $ ps a (b,lb)
                where
                  ps a (b,lb) | a == b = [[a]]
                              | a /=b = (b:) <$> concat (ps a <$> adj_ b lb)
                  bfs = bfsl g a
                  adj_ b lb = catMaybes [find ((v, lb-1) ==) bfs | v <- adj g b]

