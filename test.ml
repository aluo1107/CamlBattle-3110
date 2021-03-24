open OUnit2
open Camltypes
open Attack

(* The helper test functions*)
let attack_multi_test
    (name : string)
    (input_caml : Camltypes.t)
    (input_wolf : Camltypes.t)
    (expected_output : int) : test =
  name >:: fun _ ->
  assert_equal expected_output attack_multi input_caml input_wolf

let caml_type_test
    (name : string)
    (input_caml : Camltypes.t)
    (expected_output : string) : test =
  name >:: fun _ -> assert_equal expected_output caml_type input_caml

let current_hp_test
    (name : string)
    (input_caml : Camltypes.t)
    (expected_output : int) : test =
  name >:: fun _ -> assert_equal expected_output current_hp input_caml

let example_caml =
  {
    hp = 10;
    level = 1;
    element_t = "fire";
    moves = [ "attack"; "defense"; "heal" ];
  }

let example_wolf =
  {
    hp = 10;
    level = 1;
    element_t = "water";
    moves = [ "attack"; "defense"; "heal" ];
  }

(* Test suites for each Compilation Unit*)
let camltypes_test =
  [ attack_multi_test "Basic match up" example_caml example_wolf 0 ]

let attack_test = []
