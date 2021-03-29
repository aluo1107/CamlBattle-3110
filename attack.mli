open Camltypes

(* keeping track of attacks in the game*)

exception UnknownMove of move_t

type t = move_t

(** [move attacker victim stage move] applies the move made by the
    attacker either on themself or the victim, depending on if the move
    was Attack, Defense, or Heal. Requires [attacker] and [victim] be a
    valid Camltype.t, [stage] be a valid Camltypes.stage and [move] be a
    valid Camltypes.move_t*)
val move :
  Camltypes.t ->
  Camltypes.t ->
  Camltypes.stage ->
  Camltypes.move_t ->
  Camltypes.t
