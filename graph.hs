{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE FlexibleContexts #-}
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


g :: Graph Integer
g = G [Ue (1, 2), Ue (2,3) , Ue (7,1),Ue (2,8),Ue (8,3),Ue (1,9),Ue (3,7)]

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

-- Conta quantos amigos o no 'a' tem em comum com o no 'b'
countCommonFriends :: Eq a => Graph a -> a -> a -> Int
countCommonFriends g a b = length(getCommonFriends g a b)

-- Transforma toda a lista de no em (score, id)
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