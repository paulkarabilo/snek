module Subscriptions exposing (subscriptions)

import Time
import Keyboard
import Model.Direction exposing (Direction(..))
import Action exposing (Action(..))

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
