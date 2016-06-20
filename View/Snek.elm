module View.Snek exposing (render)

import Html exposing (..)
import Html.Attributes exposing (..)

import Model.Coord exposing (Coord)
import Action exposing (Action)

render : Coord -> Html Action
render p =
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
