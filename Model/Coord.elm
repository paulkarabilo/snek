module Model.Coord exposing (Coord, eq, contains)

type alias Coord = { x: Int, y: Int }

eq : Coord -> Coord -> Bool
eq c1 c2 = c1.x == c2.x && c1.y == c2.y

contains : List Coord -> Coord -> Bool
contains list a =
  (list
    |> List.filterMap (\i -> if (eq i a) then Just True else Nothing)
    |> List.length) > 0

