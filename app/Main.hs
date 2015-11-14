module Main where

import Linear
import Maze
import System.Random
import System.Environment

main :: IO ()
main = do
    (w:h:rest) <- getArgs

    let (filled, empty) = case rest of
                              [] -> ("██", "  ")
                              [a, b] -> (a,b)

    let size = (read <$> V2 w h)*2-1
    gen <- newStdGen
    let grid = genMaze size gen
    putStrLn . unlines $ renderGrid filled empty size grid
