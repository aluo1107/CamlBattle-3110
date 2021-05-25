open Camltypes
open State

(** attack_base is the base amount of damage dealt by the camls*)
let attack_base = 1

(** heal_base is the base amount of health healed by the camls*)
let heal_base = 1

(** Defense base is the base amount of damage blocked by the caml. It is
    higher than heal because there is a chance it won't be used*)
let defense_base = 2

(** This exception is called when an unknown move is called.*)
exception UnknownMove of move_t

(** The type for moves.*)
type t = move_t

(** [change_turn turn ]is a helper for [move] which changes the boolean
    indicating if it was the player turn. Requires: [turn] be a bool. *)
let change_turn (turn : bool) =
  match turn with true -> false | false -> true

(** [get_multiplier effect] is a helper function that returns the effect
    multiplier. Requires: [effect] be a valid Camltypes.effect*)
let get_multiplier effect = effect_multi effect

(** [get_stage_multiplier stage_effect] is a helper function that
    returns the stage multiplier. Requires: [stage_effect] be a valid
    Camltypes.stage_effect*)
let get_stage_multiplier stage_effect = stage_multi stage_effect

(** [attack_move attacker victim stage move] is a helper function that
    returns how much damage is done to the victim. Requires: [attacker]
    and [victim] be a valid Camltypes.t, [stage] be a valid Stages.t and
    [move] be a valid type t *)
let attack_move attacker victim state =
  let attack_multiplier =
    get_multiplier
      (attack_multi (caml_type attacker) (caml_type victim))
  in
  let attack_damage_type =
    attack_multiplier *. float_of_int attack_base
  in
  let attack_multi_stage =
    get_stage_multiplier
      (attack_stage_multi attacker.element_t state.stage)
  in
  int_of_float (attack_damage_type *. attack_multi_stage)
  - current_defense victim + 1

(** [change_victim_hp victim attack_dam] is a helper function that
    changes the hp of victim by returning a new victim with the correct
    hp. It resets the defense to 0 because a turn is gone. Requires
    [victim] to be a valid Camltypes.t and [attack_dam] be an int *)
let change_victim_hp victim attack_dam =
  {
    victim with
    hp =
      (let new_hp = victim.hp - attack_dam in
       if new_hp > victim.hp then victim.hp else new_hp);
    defense = 0;
  }

(** [attacking_move state attacker victim player_attacker] is a helper
    function where the caml that is going is attacking the other caml. *)
let attacking_move state attacker victim player_attacker =
  let attack_dam = attack_move attacker victim state in

  if player_attacker then
    {
      state with
      ai = change_victim_hp victim attack_dam;
      turn = change_turn player_attacker;
    }
  else
    {
      state with
      player = change_victim_hp victim attack_dam;
      turn = change_turn player_attacker;
    }

(** [defense_move state attacker victim player_attacker] is a helper
    function that handles the caml defending itself from an attack. *)
let defense_move state attacker victim player_attacker =
  if player_attacker then
    {
      state with
      player = updated_defense attacker (defense_base * attacker.level);
      ai = updated_defense victim 0;
      turn = change_turn player_attacker;
    }
  else
    {
      state with
      player = updated_defense victim 0;
      ai = updated_defense attacker (defense_base * attacker.level);
      turn = change_turn player_attacker;
    }

(** [heal_move state attacker victim player_attacker] is a helper
    function that handle the caml healing itself*)
let heal_move state attacker victim player_attacker =
  if player_attacker then
    {
      state with
      player =
        (let new_hp = attacker.hp + (heal_base * attacker.level) in
         if new_hp > attacker.level * 10 then
           updated_hp attacker (-((attacker.level * 10) - attacker.hp))
         else updated_hp attacker (-(heal_base * attacker.level)));
      ai = updated_defense victim 0;
      turn = change_turn player_attacker;
    }
  else
    {
      state with
      player = updated_defense victim 0;
      ai =
        (let new_hp = attacker.hp + (heal_base * attacker.level) in
         if new_hp > attacker.level * 10 then
           updated_hp attacker (-((attacker.level * 10) - attacker.hp))
         else updated_hp attacker (-(heal_base * attacker.level)));
      turn = change_turn player_attacker;
    }

(** [move state attacker victim move player_attacker] applies the move
    made by the attacker either on themself or the victim, depending on
    if the move was Attack, Defense, or Heal. Requires [state] to be a
    valid State.t, [attacker] and [victim] be a valid Camltype.t, [move]
    be a valid Camltypes.move_t, [player_attacker] to be a valid bool
    that is true if the player is the attacker or false if the player is
    not the attacker.*)
let move (state : State.t) attacker victim move player_attacker =
  match move with
  | Attack -> attacking_move state attacker victim player_attacker
  | Defense -> defense_move state attacker victim player_attacker
  | Heal -> heal_move state attacker victim player_attacker
