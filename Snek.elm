module Snek exposing (main)

import Html exposing (span, div, text)
import Html.App as App
import Keyboard

type alias Coord = {
  x: Int,
  y: Int
}

type Direction = Up | Down | Left | Right

type alias Snek = {
  body: List Coord
}

snek : Snek
snek = {
    body = []
  }

type alias Field = {
  cells: List Coord
}

field : Field
field = {
    cells = []
  }

type alias Rabbit = {
  coord: Coord
}

rabbit : Rabbit
rabbit = {
    coord = {
      x = 0,
      y = 0
    }
  }

type alias Model = {
  dir: Direction,
  field: Field,
  snek: Snek,
  rabbit: Rabbit
}

model : Model
model = {
    dir = Left,
    field = field,
    snek = snek,
    rabbit = rabbit
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

view : Model -> Html.Html Action
view model =
  span [] [text (dirToStr model.dir)]
