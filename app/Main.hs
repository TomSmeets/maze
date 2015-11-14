module Main where

import Linear
import Maze
import System.Random
import System.Environment

main :: IO ()
main = do
    [w, h] <- getArgs
    let size = (read <$> V2 w h)*2-1
    gen <- newStdGen
    let grid = genMaze size gen
    putStrLn $ renderGrid size grid
