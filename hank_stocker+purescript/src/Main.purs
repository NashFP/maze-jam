module Main where

import Data.Array
import Data.Traversable
import MazeRendering
import Prelude

import Data.List.Lazy (replicate)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Random (randomInt)
import Graphics.Canvas (getCanvasElementById, getContext2D)
import Partial.Unsafe (unsafePartial)

grid :: Int -> Array MazeTile
grid size = do
  y <- 0 .. (size - 1)
  x <- 0 .. (size - 1)
  pure { x: x, y: y, mask: 0 }

randomMask :: Effect Int
randomMask = randomInt 0 15

randomizeTile :: MazeTile -> Effect MazeTile
randomizeTile tile = do
  mask <- randomMask
  pure $ tile { mask = mask }

randomMaze ∷ Int → Effect (Array MazeTile)
randomMaze size = traverse randomizeTile (grid size)

blasuccianArrayToMaze :: Array (Array Mask) -> Array MazeTile
blasuccianArrayToMaze xs = do
  let indexed = mapWithIndex (\n -> (mapWithIndex (\j mask -> {y: n, x: j, mask: mask})))
  join $ indexed xs

-- main :: Effect Unit
-- main = void $ unsafePartial do
--   Just canvas <- getCanvasElementById "canvas"
--   ctx <- getContext2D canvas
--   let colors = {floor: "#1f83f4", walls: "#000000"}
--   theMaze <- randomMaze 8
--   traverse (drawCell ctx colors) $ theMaze

main :: Effect Unit
main = void $ unsafePartial do
  Just canvas <- getCanvasElementById "canvas"
  ctx <- getContext2D canvas
  let colors = {floor: "#1f83f4", walls: "#000000"}
  let maze = blasuccianArrayToMaze pbMaze
  traverse (drawCell ctx colors) $ maze

pbMaze :: Array (Array Mask)
pbMaze = 
  [
    [ 2, 14, 10, 14,  8 ],
    [ 5,  9, 11, 13, 11 ],
    [ 3, 15,  9, 15,  9 ],
    [ 7, 15, 13, 15, 11 ],
    [ 1, 13,  9,  9,  9 ]
  ]

--http://weblog.jamisbuck.org/2010/12/29/maze-generation-eller-s-algorithm

-- ellerMaze :: Int -> Int -> Effect (Array MazeTile)
-- genMaze w h horizontalBias verticalBias = do
--   let makeRow y = 
--     let empty = replicate w { y: y, x: 0, mask: 0}
    
--   --initialize row of cells, each belonging to own set
--     --randomly merge sets horizontally; merged sets become a new single set
--     --iterate to next row
--     --randomly extend sets down. each set has at least one vertical connection
--     --assign divisions in this new row to new sets, loop
--   --once bottom has been reached, merge any disjoint cells
--   --run along matrix and
--     --seal all walls (i.e. west walls on west side)
--     --puncture entrance and exit
--   pure []