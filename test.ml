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

let exp_update_test
    (name : string)
    (input_caml : Camltypes.t)
    (expected_output : Camltypes.t) : test =
  name >:: fun _ -> assert_equal expected_output (exp_update input_caml)

(* Example cases to play with in the test suites.*)

let example_caml_el = "fire"

let example_enemy_el = "water"

let defense_move = Defense

let attack_move = Attack

let heal_move = Heal

let move_set = [ Attack; Defense; Heal ]

let example_caml =
  {
    hp = 10;
    level = 1;
    element_t = example_caml_el;
    moves = move_set;
    exp = 0;
  }

let example_wolf =
  {
    hp = 10;
    level = 1;
    element_t = example_enemy_el;
    moves = move_set;
    exp = 0;
  }

let max_xp_caml =
  {
    hp = 10;
    level = 1;
    element_t = example_caml_el;
    moves = move_set;
    exp = 100;
  }

let post_xp_caml =
  {
    hp = 20;
    level = 2;
    element_t = example_caml_el;
    moves = move_set;
    exp = 0;
  }

(* Test suites for each Compilation Unit*)

let camltypes_test =
  [
    attack_multi_test "Basic match up" example_caml example_wolf 0.5;
    current_hp_test "Basic health" example_caml 10;
    caml_type_test "Basic caml type" example_caml "fire";
    exp_update_test "Basic caml xp updated" max_xp_caml post_xp_caml;
  ]

let attack_test = []

let tests =
  "test suite for CamlBattle" >::: List.flatten [ camltypes_test ]

let _ = run_test_tt_main tests
