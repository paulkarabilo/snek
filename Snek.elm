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
  body: List Coord,
  dir: Direction
}

type alias Field = {
  cells: List Coord
}

type alias Rabbit = {
  coord: Coord
}

type alias Model = {
  field: Field,
  snek: Snek,
  rabbit: Rabbit
}


main = App.beginnerProgram {model = "", view = view, update = update}

type Msg = GoUp | GoDown | GoLeft | GoRight

update msg model =
  case msg of
    GoUp ->
      "Up"
    GoDown ->
      "Down"
    GoLeft ->
      "Left"
    GoRight ->
      "Right"

view model =
  span [] [text "Hello"]
