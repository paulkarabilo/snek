module View.Game exposing (render)

import View.Snek as Snek
import View.Rabbit as Rabbit
import View.Field as Field

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

import Action exposing (Action)
import Model.Game exposing (Model)

render : Model -> Html Action
render model =
  case model.gameOver of
  True -> div [class "game-over", onClick Action.Restart] [text "Game Over!, Click to Restart"]
  False ->
    div [class "snek"] [
      div [
        class "cells",
        style [
          ("position", "absolute"),
          ("left", "0px"),
          ("top", "30px"),
          ("width", "100px"),
          ("height", "100px")
        ]
      ] (List.concat [
        (List.map Snek.render model.snek),
        (List.map Field.render model.field),
        [Rabbit.render model.rabbit]
      ])
    ]
