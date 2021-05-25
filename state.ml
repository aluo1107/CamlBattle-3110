open Camltypes

(* This is the type t for state that has player caml, ai caml, stage,
   and who's turn it is.*)
type t = {
  player : Camltypes.t;
  ai : Camltypes.t;
  stage : Camltypes.stage;
  turn : bool;
}
