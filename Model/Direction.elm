module Model.Direction exposing (Direction(..), inverse)

type Direction = Up | Down | Left | Right

inverse : Direction -> Direction
inverse ins =
  case ins of
    Up -> Down
    Down -> Up
    Left -> Right
    Right -> Left
