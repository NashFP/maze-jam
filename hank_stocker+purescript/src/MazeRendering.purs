module MazeRendering where
  
import Prelude

import Data.Int (toNumber)
import Data.Int.Bits (and)
import Effect (Effect)
import Graphics.Canvas (Context2D, Rectangle, fillPath, rect, setFillStyle)

type Mask = Int

type MazeTile = 
  { x    :: Int
  , y    :: Int
  , mask :: Mask }

type CanvasXY = { x :: Number, y :: Number }
type CellColor = { floor :: String, walls :: String }

drawCell :: Context2D -> CellColor -> MazeTile -> Effect Unit
drawCell ctx color tile = do
  let coords = mazeTileToCoords tile
  _ <- setFillStyle ctx color.floor
  fillPath ctx (cellBase ctx coords)
  _ <- setFillStyle ctx color.walls
  fillPath ctx (drawAllColumns ctx coords)
  fillPath ctx (drawAllWalls ctx coords tile.mask)

mazeTileToCoords :: MazeTile -> CanvasXY
mazeTileToCoords coords = 
  { x: toNumber coords.x * 100.0
  , y: toNumber coords.y * 100.0 }

cellBase :: Context2D -> CanvasXY -> Effect Unit
cellBase ctx canvas = 
  rect ctx
    { x: canvas.x
    , y: canvas.y
    , width: 100.0
    , height: 100.0
    }

data Corner = UL | UR | BL | BR
data Direction = North | South | East | West

hasExit :: Direction -> Mask -> Boolean
hasExit dir mask = (and mask (maskFromDir dir)) /= 0

maskFromDir :: Direction -> Int
maskFromDir x = case x of
  North -> 1
  South -> 2
  East  -> 4
  West  -> 8

drawAllColumns :: Context2D -> CanvasXY -> Effect Unit
drawAllColumns ctx coords =
  col UR <> col UL <> col BL <> col BR where
    col corner = (drawColumn ctx coords corner)

drawColumn :: Context2D -> CanvasXY -> Corner -> Effect Unit
drawColumn ctx coords corner = 
  rect ctx
    { x: (offset.x + coords.x)
    , y: (offset.y + coords.y)
    , width: 20.0
    , height: 20.0
    }
  where offset = columnPos corner

columnPos :: Corner -> CanvasXY
columnPos corner =
  case corner of
    UL -> { x: 0.0,  y: 0.0  }
    BL -> { x: 0.0,  y: 80.0 }
    UR -> { x: 80.0, y: 0.0  }
    BR -> { x: 80.0, y: 80.0 }

drawAllWalls :: Context2D -> CanvasXY -> Mask -> Effect Unit
drawAllWalls ctx coords mask = do
  let draw dir = if (not (hasExit dir mask)) then drawWall ctx coords dir else pure unit
  draw North
  draw South
  draw East
  draw West

drawWall :: Context2D -> CanvasXY -> Direction -> Effect Unit
drawWall ctx coords dir =
  rect ctx 
    { x: (wall.x + coords.x) 
    , y: (wall.y + coords.y)
    , width: wall.width
    , height: wall.height
    }
  where wall = wallPos dir

wallPos :: Direction -> Rectangle
wallPos dir =
  case dir of
    North -> { x: 20.0, y: 0.0,  width: 60.0, height: 20.0 }
    South -> { x: 20.0, y: 80.0, width: 60.0, height: 20.0 }
    East  -> { x: 80.0, y: 20.0, width: 20.0, height: 60.0 }
    West  -> { x: 0.0,  y: 20.0, width: 20.0, height: 60.0 }

