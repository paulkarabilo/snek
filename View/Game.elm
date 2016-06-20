module View.Game exposing (render)

import View.Snek as Snek
import View.Rabbit as Rabbit
import View.Field as Field

import Html exposing (..)
import Html.Attributes exposing (..)

import Action exposing (Action)
import Model.Game exposing (Model)

render : Model -> Html Action
render model =
  div [class "snek"] [
    div [] [text (toString model.dir)],
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
      (List.map Snek.render model.snek),
      (List.map Field.render model.field),
      [Rabbit.render model.rabbit]
    ])
  ]
