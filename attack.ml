open Camltypes

let attack_base = 10

let heal_base = 10

exception UnknownMove of move_t

type t = { move : move_t }

(** [get_multiplier effect] is a helper function that returns the effect
    multiplier. Requires: [effect] be a valid Camltypes.effect*)
let get_multiplier effect = effect_multi effect

(** [attack_move attacker victim stage move] is a helper function that
    returns how much damage is done to the victim. Requires: [attacker]
    and [victim] be a valid Camltypes.t, [stage] be a valid Stages.t and
    [move] be a valid type t *)
let attack_move attacker victim stage move =
  let attack_multiplier =
    get_multiplier
      (attack_multi (caml_type attacker) (caml_type victim))
  in
  let attack_damage_type =
    int_of_float attack_multiplier * attack_base
  in
  let attack_multi_stage =
    get_multiplier (attack_stage_multi attacker stage)
  in
  attack_damage_type * int_of_float attack_multi_stage

let defense_move attacker victim (stage : Stages.t) move =
  match move with
  | Attack -> updated_hp victim (attack_move attacker victim stage move)
  | Defense -> 10
  | Heal -> updated_hp victim (-(heal_base * attacker.level))
  | x -> raise (UnknownMove x)
