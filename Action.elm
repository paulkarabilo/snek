module Action exposing (Action(..), update)

import Model.Direction exposing (Direction, inverse)
import Model.Game exposing (Model, move)
import Model.Coord exposing (Coord)

type Action = KeyPress (Maybe Direction) | Tick Float | Restart | Exit


delta: List Coord -> Float
delta snek =
  (snek |> List.length |> toFloat |> logBase 2) * 100

invalidDir : Direction -> Direction -> Bool
invalidDir newDir snekDir =
  newDir == inverse snekDir

update : Action -> Model -> (Model, Cmd Action)
update action model =
  case action of
    KeyPress d ->
      case d of
        Nothing -> model ! []
        Just di ->
          if invalidDir di model.dir then model ! []
          else move {model | dir = di} (model.lastTick + 1) ! []
    Tick f ->
      (if (f - model.lastTick) > (delta model.snek) then move model f else model) ! []
    Restart ->
      model ! []
    Exit ->
      model ! []
