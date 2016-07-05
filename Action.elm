module Action exposing (Action(..), update)

import Model.Direction exposing (Direction)
import Model.Game exposing (Model, move)

type Action = KeyPress (Maybe Direction) | Tick Float | Restart | Exit

update : Action -> Model -> (Model, Cmd Action)
update action model =
    case action of
      KeyPress d ->
        case d of
          Nothing ->
            model ! []
          Just di ->
            {model | dir = di} ! []
      Tick f ->
        let
          delta = 1000 / logBase 2 (model.snek |> List.length |> toFloat)
          last = model.lastTick
          frame = (f - last) > delta
        in
          (if frame then move model f else model) ! []
      Restart ->
        model ! []
      Exit ->
        model ! []
