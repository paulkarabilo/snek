module Snek exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Time
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
  rabbit: Coord,
  lastTick: Float
}

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
    view = view,
    update = update,
    subscriptions = subscriptions
  }

type Action = KeyPress (Maybe Direction) | Tick Float | Restart | Exit

nextHead : Coord -> Direction -> List Coord -> Coord
nextHead head dir field =
  let
    size = field |> List.length |> toFloat |> sqrt |> round
    hx = head.x
    hy = head.y
  in
    case dir of
      Up ->
        {x = hx, y = if hy == 0 then size - 1 else hy - 1}
      Down ->
        {x = hx, y = if hy == size - 1 then 0 else hy + 1}
      Left ->
        {x = if hx == 0 then size - 1 else hx - 1, y = hy}
      Right ->
        {x = if hx == size - 1 then 0 else hx + 1, y = hy}

moveSnek : (List Coord) -> Direction -> (List Coord) -> (List Coord)
moveSnek snek dir field =
  let
    head = List.head snek
  in
    case head of
      Nothing ->
        snek
      Just h ->
        (nextHead h dir field) :: (List.take ((List.length snek) - 1) snek)

moveModel : Model -> Float -> Model
moveModel model tick =
  { model |
    lastTick = tick,
    snek = moveSnek model.snek model.dir model.field
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
        in
          (if ((f - last) > delta) then (moveModel model f) else model) ! []
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
  div [
    class "cell",
    style [
      ("position", "absolute"),
      ("width", "50px"),
      ("height", "50px"),
      ("left", (toString (p.x * 50)) ++ "px"),
      ("top", (toString (p.y * 50)) ++ "px")
    ]
  ] []

rabbit2html : Coord -> Html Action
rabbit2html p =
  div [
    class "snek-cell",
    style [
      ("position", "absolute"),
      ("width", "50px"),
      ("height", "50px"),
      ("left", (toString (p.x * 50)) ++ "px"),
      ("top", (toString (p.y * 50)) ++ "px"),
      ("background-color", "white")
    ]
  ] []

snek2html : Coord -> Html Action
snek2html p =
  div [
    class "snek-cell",
    style [
      ("position", "absolute"),
      ("width", "50px"),
      ("height", "50px"),
      ("left", (toString (p.x * 50)) ++ "px"),
      ("top", (toString (p.y * 50)) ++ "px"),
      ("background-color", "white")
    ]
  ] []

view : Model -> Html Action
view model =
  div [class "snek"] [
    div [] [text (dirToStr model.dir)],
    div [] [text (toString model.lastTick)],
    div [
      class "cells",
      style [
        ("position", "absolute"),
        ("left", "0px"),
        ("top", "30px"),
        ("width", "500px"),
        ("height", "500px")
      ]
    ] (List.concat [
      (List.map snek2html model.snek),
      (List.map field2html model.field),
      [rabbit2html model.rabbit]
    ])
  ]
