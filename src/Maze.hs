{-# LANGUAGE BangPatterns #-}
module Maze (renderGrid, genMaze) where

import Control.Monad.State
import Linear
import System.Random

-- | Alias for the maze generator
type MazeGen a = State (StdGen, Grid) a

-- | The grid is a collection of all non-wall pieces
type Grid = [Point]

-- | A position inside the grid type
type Point = V2 Integer

-- | The grid size
type Size = V2 Integer

-- | Render the grid to a list of lines
renderGrid :: String     -- ^ What 'String' to use to render a wall
           -> String     -- ^ What 'String' to user to render an empty space/path
           -> Size       -- ^ The grid size
           -> Grid       -- ^ Input grid
           -> [String]   -- ^ Output lines
renderGrid wall empty (V2 sx sy) grid = [concat [renderPos (V2 x y) | x <- [-1..sx]] | y <- [-1..sy]]
  where
    -- | Get the correct 'String' for this location
    renderPos v = if v `elem` grid
      then empty
      else wall

-- | Generat a maze of the given size
genMaze :: Size       -- ^ The grid size
        -> StdGen     -- ^ Random number generator
        -> Grid       -- ^ Generated grid
genMaze size g = snd $ execState (let p = (round <$> (fromIntegral <$> size) / 2) in iter p p) (g,[])
  where
    iter :: Point -> Point -> MazeGen ()
    iter p' p = do
        (gen, !grid) <- get
        when (valid grid p) $ do
            let (ndirs, gen') = shuffle gen dirs
            put (gen', p:p':grid)
            forM_ ndirs $ \d -> iter (p+d) (p+d*2)

    -- | All four walkable directions
    dirs :: [Point]
    dirs = [ V2   1    0
           , V2 (-1)   0
           , V2   0    1
           , V2   0  (-1)
           ]

    -- | Check if this point is inside the grid and not already used
    valid :: Grid -> Point -> Bool
    valid grid p = inside p && p `notElem` grid

    -- | Chick if this Point lies inside the grid
    inside :: Point -> Bool
    inside (V2 x y) = let V2 sx sy = size
                      in  and [ x < sx, x >= 0
                              , y < sy, y >= 0 ]

-- | shuffle a list
shuffle :: RandomGen g => g -> [a] -> ([a], g)
shuffle gen [] = ([], gen)
shuffle gen xs = (e:rest, gen'')
  where
    (i, gen')    = randomR (0, length xs - 1) gen
    (ys, e:zs)   = splitAt i xs
    (rest,gen'') = shuffle gen' (ys++zs)
