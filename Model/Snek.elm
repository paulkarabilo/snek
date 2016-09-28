module Model.Snek exposing (move, eat)

import Model.Coord exposing (Coord)
import Model.Direction exposing (Direction(..), inverse)

normalize : Int -> Int -> Int
normalize val size =
  if val < 0 then
    size - 1
  else if val > size - 1 then
    0
  else
    val

nextHead : Coord -> Direction -> List Coord -> Coord
nextHead head dir field =
  let
    size = field |> List.length |> toFloat |> sqrt |> round
    (hx, hy) = (head.x, head.y)
  in
    case dir of
      Up -> {x = hx, y = normalize (hy - 1) size}
      Down -> {x = hx, y = normalize (hy + 1) size}
      Left -> {x = normalize (hx - 1) size, y = hy}
      Right -> {x = normalize (hx + 1) size, y = hy}


move : List Coord -> Direction -> List Coord -> List Coord
move snek dir field =
  let
    (head, len) = (List.head snek, List.length snek)
  in
    case head of
      Nothing ->
        snek
      Just h ->
        nextHead h dir field :: List.take (len - 1) snek

eat: List Coord -> Direction -> List Coord -> List Coord
eat snek dir field =
  let
    tail = snek |> List.reverse |> List.head
    invdir = inverse dir
  in
    case tail of
      Nothing ->
        snek
      Just t ->
        List.append snek [nextHead t invdir field]
