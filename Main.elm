module Main exposing (main)

import Html exposing (Html)
import Html.Attributes exposing (..)


import View.Game as Game
import Model.Game exposing (Model, model)
import Action exposing (Action(..), update)
import Subscriptions exposing (subscriptions)


init : (Model, Cmd Action)
init =
  (model, Cmd.none)


main : Program Never Model Action
main = Html.program
  {
    init = init,
    view = Game.render,
    update = update,
    subscriptions = subscriptions
  }
