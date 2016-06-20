module Action exposing (Action(..))

import Model.Direction exposing (Direction)

type Action = KeyPress (Maybe Direction) | Tick Float | Restart | Exit
