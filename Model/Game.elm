module Model.Game exposing (Model, move, model)

import Model.Direction exposing (Direction(..))
import Model.Coord exposing (Coord, equals, contains)
import Model.Snek as Snek
import Random as Random

type alias Model = {
  dir: Direction,
  field: List Coord,
  snek: List Coord,
  rabbit: Coord,
  lastTick: Float,
  seed: Random.Seed
}

model : Model
model = {
    dir = Left,
    field = List.concatMap (\x -> List.map (\y -> {x = x, y = y}) [0..9]) [0..9],
    snek = [{x = 5, y = 5}, {x = 6, y = 5}, {x = 7, y = 5}],
    rabbit = {x = 3, y = 4},
    lastTick = 0,
    seed = Random.initialSeed 42
  }



getFreeCells : List Coord -> List Coord -> List Coord
getFreeCells field snek =
  let
    head = List.head field
    tail = List.tail field
  in
    case head of
      Nothing ->
        []
      Just h ->
        if contains snek h then
          case tail of
            Nothing -> []
            Just t -> t
        else
          case tail of
            Nothing ->
              h :: []
            Just t ->
              h :: getFreeCells t snek

nextRabbit : List Coord -> List Coord -> Random.Seed -> (Maybe Coord, Random.Seed)
nextRabbit field snek seed =
  let
    freeCells = getFreeCells field snek
    len = List.length freeCells
    n = Random.int 0 (len - 1)
    (nextR, nextSeed) = Random.step n seed
  in
    (List.head (List.drop nextR freeCells), nextSeed)



move : Model -> Float -> Model
move model tick =
  let
    nextSnek = Snek.move model.snek model.dir model.field
    rabbit = model.rabbit
    nextHead = List.head nextSnek
  in
    case nextHead of
      Nothing ->
        { model | lastTick = tick, snek = nextSnek }
      Just h ->
        if equals h rabbit then
          let
            (rabbit, seed) = nextRabbit model.field model.snek model.seed
          in
            case rabbit of
              Nothing ->
                { model | lastTick = tick, snek = Snek.eat nextSnek model.dir model.field }
              Just r ->
                { model | lastTick = tick, snek = Snek.eat nextSnek model.dir model.field, rabbit = r }
        else
          { model | lastTick = tick, snek = nextSnek }
