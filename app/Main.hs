module Main where

import Linear
import Maze
import System.Environment
import System.Random

main :: IO ()
main = do
    args <- getArgs
    let (size, filled, empty) = case args of
                                  [w,h]     -> (read <$> V2 w h, "██", "  ")
                                  [w,h,a,b] -> (read <$> V2 w h, a, b)
                                  _         -> error "Invalid amount of arguments"
    let realSize = size*2 - 1
    gen <- newStdGen
    let grid = genMaze realSize gen
    putStrLn . unlines $ renderGrid filled empty realSize grid
