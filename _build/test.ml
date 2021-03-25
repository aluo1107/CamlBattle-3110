open OUnit2
open Camltypes
open Attack

(* The helper test functions*)
let attack_multi_test
    (name : string)
    (input_caml : Camltypes.t)
    (input_wolf : Camltypes.t)
    (expected_output : float) : test =
  name >:: fun _ ->
  assert_equal expected_output
    (effect_multi (attack_multi input_caml input_wolf))

let caml_type_test
    (name : string)
    (input_caml : Camltypes.t)
    (expected_output : Camltypes.element_t) : test =
  name >:: fun _ -> assert_equal expected_output (caml_type input_caml)

let current_hp_test
    (name : string)
    (input_caml : Camltypes.t)
    (expected_output : int) : test =
  name >:: fun _ -> assert_equal expected_output (current_hp input_caml)

(* Example cases to play with in the test suites.*)

let example_caml_el = "fire"

let example_enemy_el = "water"

let defense_move = "defense"

let attack_move = "attack"

let heal_move = "heal"

let move_set = [ attack_move; defense_move; heal_move ]

(* let example_caml = { hp = 10; level = 1; element_t = example_caml_el;
   moves = move_set }

   let example_wolf = { hp = 10; level = 1; element_t =
   example_enemy_el; moves = move_set } *)

(* Test suites for each Compilation Unit*)
let camltypes_test =
  [ (*attack_multi_test "Basic match up" example_caml example_wolf 0.5 *) ]

let attack_test = []
