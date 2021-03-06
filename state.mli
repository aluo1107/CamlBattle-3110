(** Contains the main state*)
open Camltypes

(** The battle state in CamlBattle. *)
type t = {
  player : Camltypes.t;
  ai : Camltypes.t;
  stage : Camltypes.stage;
  turn : bool;
}
