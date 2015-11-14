{-# LANGUAGE BangPatterns #-}
module Maze where

import Control.Monad.State
import Debug.Trace
import Linear hiding (trace)
import System.Random

type Grid = [V2 Integer]
type MazeGen a = State (StdGen, Grid) a

renderGrid :: String -> String -> V2 Integer -> Grid -> [String]
renderGrid wall empty (V2 sx sy) grid = [concat [f x y | x <- [-1..sx]] | y <- [-1..sy]]
  where
    f x y= if V2 x y `elem` grid
      then empty
      else wall

genMaze :: V2 Integer -> StdGen -> Grid
genMaze size g = snd $ execState (let p = (round <$> (fromIntegral <$> size) / 2) in iter p p) (g,[])
  where
    iter :: V2 Integer -> V2 Integer -> MazeGen ()
    iter p' p = do
        (gen, !grid) <- get
        when (valid grid size p) $ do
            let (ndirs, gen') = shuffle dirs gen
            put (gen', p:p':grid) 
            forM_ ndirs $ \d -> iter (p+d) (p+d*2)
    
dirs = [ V2   1    0 
       , V2 (-1)   0 
       , V2   0    1 
       , V2   0  (-1)
       ]

valid grid size p = inside size p && p `notElem` grid  

inside (V2 sx sy) (V2 x y) = and [ x < sx, x >= 0
                                 , y < sy, y >= 0 ]

shuffle [] gen  = ([], gen)
shuffle xs gen  = (e:rest, gen'')
  where
    (i, gen')    = randomR (0, length xs - 1) gen
    (ys, e:zs)   = splitAt i xs
    (rest,gen'') = shuffle (ys++zs) gen'
