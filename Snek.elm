module Snek exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Time
import Keyboard

import View.Game as Game
import Model.Game exposing (Model)
import Model.Direction exposing (Direction(..))
import Model.Coord exposing (Coord)
import Model.Snek as Snek
import Action exposing (Action(..))

model : Model
model = {
    dir = Left,
    field = List.concatMap (\x -> List.map (\y -> {x = x, y = y}) [0..9]) [0..9],
    snek = [{x = 5, y = 5}, {x = 6, y = 5}, {x = 7, y = 5}],
    rabbit = {x = 3, y = 4},
    lastTick = 0
  }

init : (Model, Cmd Action)
init =
  (model, Cmd.none)


keyChange : Keyboard.KeyCode -> Maybe Direction
keyChange keyCode =
  case keyCode of
    37 -> Just Left
    39 -> Just Right
    38 -> Just Up
    40 -> Just Down
    _ -> Nothing

subscriptions _ =
  [
    Keyboard.downs (keyChange >> KeyPress),
    Time.every (16.667 * Time.millisecond) Tick
  ]
  |> Sub.batch


main : Program Never

main = App.program
  {
    init = init,
    view = Game.render,
    update = update,
    subscriptions = subscriptions
  }


moveModel : Model -> Float -> Model
moveModel model tick =
  { model |
    lastTick = tick,
    snek = Snek.move model.snek model.dir model.field
  }

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
          (if frame then moveModel model f else model) ! []
      Restart ->
        model ! []
      Exit ->
        model ! []


