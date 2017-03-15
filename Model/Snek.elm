module Model.Snek exposing (move, eat, check)

import Model.Coord exposing (Coord, eq)
import Model.Direction exposing (Direction(..), inverse)

normalize : Int -> Int -> Int
normalize val size =
  if val < 0 then size - 1
  else if val > size - 1 then 0
  else val


fieldSize : List Coord -> Int
fieldSize field =
  field |> List.length |> toFloat |> sqrt |> round

check: List Coord -> Bool
check snek =
  let
    head = snek |> List.head
    tail = snek |> List.tail
  in
    case head of
      Nothing -> False
      Just h ->
        case tail of
          Nothing -> False
          Just t -> List.length (List.filter (\c -> eq c h) t) > 0

nextHead : Coord -> Direction -> List Coord -> Coord
nextHead h dir field =
  case dir of
    Up -> {x = h.x, y = normalize (h.y - 1) (fieldSize field)}
    Down -> {x = h.x, y = normalize (h.y + 1) (fieldSize field)}
    Left -> {x = normalize (h.x - 1) (fieldSize field), y = h.y}
    Right -> {x = normalize (h.x + 1) (fieldSize field), y = h.y}


move : List Coord -> Direction -> List Coord -> List Coord
move snek dir field =
  case List.head snek of
    Nothing -> snek
    Just h -> nextHead h dir field :: List.take (List.length snek - 1) snek


eat: List Coord -> Direction -> List Coord -> List Coord
eat snek dir field =
  case snek |> List.reverse |> List.head of
    Nothing -> snek
    Just t -> List.append snek [nextHead t (inverse dir) field]
