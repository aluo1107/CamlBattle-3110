open Camltypes

(** keeping track of attacks in the game *)

exception UnknownMove of move_t

type t = move_t

(** [move state attacker victim move player_attacker] applies the move
    made by the attacker either on themself or the victim, depending on
    if the move was Attack, Defense, or Heal. Requires [state] to be a
    valid State.t, [attacker] and [victim] be a valid Camltype.t, [move]
    be a valid Camltypes.move_t, [player_attacker] to be a valid bool
    that is true if the player is the attacker or false if the player is
    not the attacker.*)
val move :
  State.t ->
  Camltypes.t ->
  Camltypes.t ->
  Camltypes.move_t ->
  bool ->
  State.t
