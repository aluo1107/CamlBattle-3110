open Camltypes

(**base amount of damage dealt by the camls.*)
val attack_base : int

(**base amount of health healed by the camls.*)
val heal_base : int

(**base amount of damage blocked by the caml.*)
val defense_base : int

(** This exception is called when an unknown move is called.*)
exception UnknownMove of move_t

(** The type for moves.*)
type t = move_t

(** [change_turn turn ]is a helper for [move] which changes the boolean
    indicating if it was the player turn. Requires: [turn] be a bool. *)
val change_turn : bool -> bool

(** [get_multiplier effect] is a helper function that returns the effect
    multiplier. Requires: [effect] be a valid Camltypes.effect*)
val get_multiplier : Camltypes.effect -> float

(** [get_stage_multiplier stage_effect] is a helper function that
    returns the stage multiplier. Requires: [stage_effect] be a valid
    Camltypes.stage_effect*)
val get_stage_multiplier : Camltypes.stage_effect -> float

(** [attack_move attacker victim stage move] is a helper function that
    returns how much damage is done to the victim. Requires: [attacker]
    and [victim] be a valid Camltypes.t, [stage] be a valid Stages.t and
    [move] be a valid type t *)
val attack_move : Camltypes.t -> Camltypes.t -> State.t -> int

(** [change_victim_hp victim attack_dam] is a helper function that
    changes the hp of victim by returning a new victim with the correct
    hp. It resets the defense to 0 because a turn is gone. Requires
    [victim] to be a valid Camltypes.t and [attack_dam] be an int *)

val change_victim_hp : Camltypes.t -> int -> Camltypes.t

(** [attacking_move state attacker victim player_attacker] is a helper
    function where the caml that is going is attacking the other caml. *)
val attacking_move :
  State.t -> Camltypes.t -> Camltypes.t -> bool -> State.t

(* [defense_move state attacker victim player_attacker] is a helper
   function that handles the caml defending itself from an attack. *)
val defense_move :
  State.t -> Camltypes.t -> Camltypes.t -> bool -> State.t

(* [heal_move state attacker victim player_attacker] is a helper
   function that handle the caml healing itself*)
val heal_move : State.t -> Camltypes.t -> Camltypes.t -> bool -> State.t

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
