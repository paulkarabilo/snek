module View.Field exposing (render)

import Html exposing (..)
import Html.Attributes exposing (..)

import Model.Coord exposing (Coord)
import Action exposing (Action)

render : Coord -> Html Action
render p =
  div [
    class "cell",
    style [
      ("position", "absolute"),
      ("width", "10px"),
      ("height", "10px"),
      ("left", (toString (p.x * 10)) ++ "px"),
      ("top", (toString (p.y * 10)) ++ "px")
    ]
  ] []
