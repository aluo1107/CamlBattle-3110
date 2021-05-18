open Camltypes
open State

let attack_base = 3

let heal_base = 1

(*Defense base is higher because there is a chance it won't be used*)
let defense_base = 2

exception UnknownMove of move_t

type t = move_t

let change_turn (turn : bool) =
  match turn with true -> false | false -> true

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
    get_multiplier (attack_stage_multi attacker.element_t state.stage)
  in
  (attack_damage_type * int_of_float attack_multi_stage)
  - current_defense victim

let change_victim_hp victim attack_dam =
  {
    victim with
    hp =
      (let new_hp = victim.hp - (attack_dam - victim.defense) in
       if new_hp > victim.hp then victim.hp else new_hp);
    defense = 0;
  }

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

let move (state : State.t) attacker victim move player_attacker =
  match move with
  | Attack -> attacking_move state attacker victim player_attacker
  | Defense -> defense_move state attacker victim player_attacker
  | Heal -> heal_move state attacker victim player_attacker
