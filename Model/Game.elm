module Model.Game exposing (Model)

import Model.Direction exposing (Direction)
import Model.Coord exposing (Coord)

type alias Model = {
  dir: Direction,
  field: List Coord,
  snek: List Coord,
  rabbit: Coord,
  lastTick: Float
}
