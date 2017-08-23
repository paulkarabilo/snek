module Action exposing (Action(..), update)

import Model.Direction exposing (Direction, inverse)
import Model.Game exposing (Model, move, restart)
import Model.Coord exposing (Coord)

type Action = KeyPress (Maybe Direction) | Tick Float | Restart | Exit

delta: List Coord -> Float
delta snek = (snek |> List.length |> toFloat |> logBase 2) * 100

moves: List Coord -> Float -> Float -> Bool
moves snek lastTick currentTick = (currentTick - lastTick) > (delta snek)

invalidDir : Direction -> Direction -> Bool
invalidDir newDir snekDir = newDir == inverse snekDir

update : Action -> Model -> (Model, Cmd Action)
update action model =
  case action of
    KeyPress d ->
      case d of
        Nothing -> model ! []
        Just di ->
          if invalidDir di model.dir then model ! []
          else move {model | dir = di} (model.lastTick + 1) ! []
    Tick f -> (if (moves model.snek model.lastTick f) then move model f else model) ! []
    Restart -> restart 42 ! []
    Exit -> model ! []
