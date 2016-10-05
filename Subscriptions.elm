module Subscriptions exposing (subscriptions)

import Time exposing (every, millisecond)
import Keyboard exposing (KeyCode, downs)
import Model.Direction exposing (Direction(..))
import Action exposing (Action(..))

keyChange : KeyCode -> Maybe Direction
keyChange keyCode =
  case keyCode of
    37 -> Just Left
    39 -> Just Right
    38 -> Just Up
    40 -> Just Down
    _ -> Nothing

subscriptions _ =
  [downs (keyChange >> KeyPress), every (16.667 * millisecond) Tick]
  |> Sub.batch
