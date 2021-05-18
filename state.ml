open Camltypes

type t = {
  player : Camltypes.t;
  ai : Camltypes.t;
  stage : Camltypes.stage;
  turn : bool;
}
