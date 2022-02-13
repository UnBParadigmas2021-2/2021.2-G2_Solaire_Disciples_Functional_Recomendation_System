{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE FlexibleContexts #-}

import Recomendation
import Graph

main :: IO ()
main = do
    print (generateRecomendations g 1)
