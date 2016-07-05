module Model.Coord exposing (Coord, equals, contains)

type alias Coord = {
  x: Int,
  y: Int
}

equals : Coord -> Coord -> Bool
equals c1 c2 =
  c1.x == c2.x && c1.y == c2.y

contains : List Coord -> Coord -> Bool
contains l a =
  let
    i = List.filterMap (\n -> if equals n a then Just True else Nothing) l
    len = List.length i
  in
    len > 0
