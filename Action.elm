module Action exposing (Action(..), update)

import Model.Direction exposing (Direction)
import Model.Game exposing (Model, move)
import Model.Coord exposing (Coord)

type Action = KeyPress (Maybe Direction) | Tick Float | Restart | Exit


delta: List Coord -> Float
delta snek =
  snek |> List.length |> toFloat |> logBase 2


update : Action -> Model -> (Model, Cmd Action)
update action model =
  case action of
    KeyPress d ->
      case d of
        Nothing -> model ! []
        Just di -> {model | dir = di} ! []
    Tick f ->
      (if (f - model.lastTick) > (delta model.snek) then move model f else model) ! []
    Restart ->
      model ! []
    Exit ->
      model ! []
