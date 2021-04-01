open Camltypes
open State

let attack_base = 10

let heal_base = 10

(*Defense base is higher because there is a chance it won't be used*)
let defense_base = 15

exception UnknownMove of move_t

type t = move_t

(** [get_multiplier effect] is a helper function that returns the effect
    multiplier. Requires: [effect] be a valid Camltypes.effect*)
let get_multiplier effect = effect_multi effect

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
    int_of_float attack_multiplier * attack_base
  in
  let attack_multi_stage =
    get_multiplier (attack_stage_multi attacker state.stage)
  in
  (attack_damage_type * int_of_float attack_multi_stage)
  - current_defense victim

let move (state : State.t) attacker victim move player_attacker =
  match move with
  | Attack ->
      if player_attacker then
        let attack_dam = attack_move attacker victim state in
        {
          state with
          ai =
            {
              victim with
              hp = victim.hp - (attack_dam - victim.defense);
              defense = 0;
            };
        }
      else
        let attack_dam = attack_move attacker victim state in
        {
          state with
          player =
            {
              victim with
              hp = victim.hp - (attack_dam - victim.defense);
              defense = 0;
            };
        }
  | Defense ->
      if player_attacker then
        {
          state with
          player =
            updated_defense attacker (defense_base * attacker.level);
          ai = updated_defense victim 0;
        }
      else
        {
          state with
          player = updated_defense victim 0;
          ai = updated_defense attacker (defense_base * attacker.level);
        }
  | Heal ->
      if player_attacker then
        {
          state with
          player = updated_hp attacker (-(heal_base * attacker.level));
          ai = updated_defense victim 0;
        }
      else
        {
          state with
          player = updated_defense victim 0;
          ai = updated_hp attacker (-(heal_base * attacker.level));
        }
