module Model.Game exposing (Model, move, model, restart)

import Model.Direction exposing (Direction(..))
import Model.Coord exposing (Coord, eq, contains)
import Model.Snek as Snek
import Random as Random

fieldSize : Int
fieldSize = 10

type alias Model = {
  dir: Direction,
  fieldSize: Int,
  field: List Coord,
  snek: List Coord,
  rabbit: Coord,
  lastTick: Float,
  seed: Random.Seed,
  gameOver: Bool
}

restart: Int -> Model
restart initialSeed = {
    dir = Left,
    fieldSize = fieldSize,
    field = List.concatMap (\x -> List.map (\y -> {x = x, y = y}) (List.range 0 (fieldSize - 1))) (List.range 0 (fieldSize - 1)),
    snek = [{x = 5, y = 5}, {x = 6, y = 5}, {x = 7, y = 5}],
    rabbit = {x = 3, y = 4},
    lastTick = 0,
    seed = Random.initialSeed initialSeed,
    gameOver = False
  }

model : Model
model = restart 42

getFreeCells : List Coord -> List Coord -> List Coord
getFreeCells field snek =
  case List.head field of
    Nothing -> []
    Just h ->
      if contains snek h then
        case List.tail field of
          Nothing -> []
          Just t -> t
      else
        case List.tail field of
          Nothing -> h :: []
          Just t -> h :: getFreeCells t snek


nextRabbit : List Coord -> List Coord -> Random.Seed -> (Maybe Coord, Random.Seed)
nextRabbit field snek seed =
  let
    freeCells = getFreeCells field snek
    (nextR, nextSeed) = Random.step (Random.int 0 ((List.length freeCells) - 1)) seed
  in
    (List.head (List.drop nextR freeCells), nextSeed)


move : Model -> Float -> Model
move model tick =
  let
    nextSnek = Snek.move model.snek model.dir model.field
  in
    case List.head nextSnek of
      Nothing ->
        { model | lastTick = tick, snek = nextSnek }
      Just h ->
        if Snek.check nextSnek then
          { model | gameOver = True }
        else if eq h model.rabbit then
          let
            (rabbit, seed) = nextRabbit model.field model.snek model.seed
          in
            case rabbit of
              Nothing ->
                { model | lastTick = tick, snek = Snek.eat nextSnek model.dir model.field }
              Just r ->
                { model | lastTick = tick, snek = Snek.eat nextSnek model.dir model.field, rabbit = r, seed = seed }
        else
          { model | lastTick = tick, snek = nextSnek }
