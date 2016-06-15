module Snek exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Keyboard

type alias Coord = {
  x: Int,
  y: Int
}

type Direction = Up | Down | Left | Right

type alias Model = {
  dir: Direction,
  field: List Coord,
  snek: List Coord,
  rabbit: Coord
}

model : Model
model = {
    dir = Left,
    field = List.concatMap (\x -> List.map (\y -> {x = x, y = y}) [0..9]) [0..9],
    snek = [{x = 5, y = 5}, {x = 5, y = 6}, {x = 5, y = 7}],
    rabbit = {x = 3, y = 4}
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
  [Keyboard.downs (keyChange >> KeyPress)]
  |> Sub.batch


main : Program Never

main = App.program
  {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
  }

type Action = KeyPress (Maybe Direction) | Restart | Exit

update : Action -> Model -> (Model, Cmd Action)
update action model =
    case action of
      KeyPress d ->
        case d of
          Nothing ->
            model ! []
          Just di ->
            {model | dir = di} ! []
      Restart ->
        model ! []
      Exit ->
        model ! []

dirToStr : Direction -> String
dirToStr dir =
  case dir of
    Up -> "Up"
    Down -> "Down"
    Left -> "Left"
    Right -> "Right"

field2html : Coord -> Html Action
field2html p =
  div [class "cell", style [("float", "left"), ("width", "50px"), ("height", "50px")]] [text (toString p.x ++ ", " ++ toString p.y)]

view : Model -> Html Action
view model =
  div [class "snek"] [
    div [] [text (dirToStr model.dir)],
    div [class "cells"] (List.map (field2html) (model.field))
  ]
