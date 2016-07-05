module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App

import View.Game as Game
import Model.Game exposing (Model, model)
import Action exposing (Action(..), update)
import Subscriptions exposing (subscriptions)

init : (Model, Cmd Action)
init =
  (model, Cmd.none)

main : Program Never
main = App.program
  {
    init = init,
    view = Game.render,
    update = update,
    subscriptions = subscriptions
  }





