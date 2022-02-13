{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE FlexibleContexts #-}

import Recomendation
import Graph
import Identification

main :: IO ()
main = do
    print (generateRecomendations g 1)
