open OUnit2
open Camltypes
open Attack
open State
open Ai

(* The helper test functions*)
let attack_multi_test
    (name : string)
    (input_caml : string)
    (input_wolf : string)
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

let updated_hp_test
    (name : string)
    (input_cam : Camltypes.t)
    (damage : int)
    (expected_output : Camltypes.t) : test =
  name >:: fun _ ->
  assert_equal expected_output (updated_hp input_cam damage)

let attack_move_test
    (name : string)
    (state : State.t)
    (expected_output : int) : test =
  name >:: fun _ ->
  assert_equal expected_output
    (move state state.player state.ai Attack true).ai.hp
    ~printer:string_of_int

let heal_test (name : string) (state : State.t) (expected_output : int)
    : test =
  name >:: fun _ ->
  assert_equal expected_output
    (move state state.player state.ai Heal true).player.hp
    ~printer:string_of_int

let defense_test
    (name : string)
    (state : State.t)
    (expected_output : int) : test =
  name >:: fun _ ->
  assert_equal expected_output state.player.defense
    ~printer:string_of_int

let ai_attack_test
    (name : string)
    (state : State.t)
    (random_num : float)
    (expected_output : int) : test =
  name >:: fun _ ->
  assert_equal expected_output (health_check random_num state).player.hp
    ~printer:string_of_int

let ai_defense_test
    (name : string)
    (state : State.t)
    (expected_output : int) : test =
  name >:: fun _ ->
  assert_equal expected_output state.ai.defense ~printer:string_of_int

let ai_heal_test
    (name : string)
    (state : State.t)
    (expected_output : int) : test =
  name >:: fun _ ->
  assert_equal expected_output state.ai.hp ~printer:string_of_int

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
    defense = 0;
    current_move = 0;
  }

let example_wolf =
  {
    hp = 10;
    level = 1;
    element_t = example_enemy_el;
    moves = move_set;
    exp = 0;
    defense = 0;
    current_move = 0;
  }

let example_state =
  {
    player = example_caml;
    ai = example_wolf;
    stage = "volcano";
    turn = true;
  }

let max_xp_caml =
  {
    hp = 10;
    level = 1;
    element_t = example_caml_el;
    moves = move_set;
    exp = 100;
    defense = 0;
    current_move = 0;
  }

let post_xp_caml =
  {
    hp = 20;
    level = 2;
    element_t = example_caml_el;
    moves = move_set;
    exp = 0;
    defense = 0;
    current_move = 0;
  }

let post_damage_caml =
  {
    hp = 9;
    level = 1;
    element_t = example_caml_el;
    moves = move_set;
    exp = 0;
    defense = 0;
    current_move = 0;
  }

(* Test suites for each Compilation Unit*)
let volcano_fire_water_def_6 =
  {
    example_state with
    player = { example_caml with defense = 6 };
    ai = { example_wolf with defense = 6 };
  }

let volcano_water_fire =
  (* Volcano biome, water player, fire ai*)
  { example_state with player = example_wolf; ai = example_caml }

let volcano_water_fire_def_6 =
  {
    volcano_water_fire with
    player = { example_wolf with defense = 6 };
    ai = { example_caml with defense = 6 };
  }

let volcano_air_earth =
  (* Volcano biome, air player, earth ai*)
  {
    example_state with
    player = { example_caml with element_t = "air" };
    ai = { example_wolf with element_t = "earth" };
  }

let volcano_air_earth_def_6 =
  {
    volcano_air_earth with
    player = { volcano_air_earth.player with defense = 6 };
    ai = { volcano_air_earth.ai with defense = 6 };
  }

let volcano_earth_air =
  (* Volcano biome, earth player, air ai*)
  {
    volcano_air_earth with
    player = volcano_air_earth.ai;
    ai = volcano_air_earth.player;
  }

let volcano_earth_air_def_6 =
  {
    volcano_earth_air with
    player = { volcano_earth_air.player with defense = 6 };
    ai = { volcano_earth_air.ai with defense = 6 };
  }

let cloud_fire_water = { example_state with stage = "cloud kingdom" }

let cloud_fire_water_def_6 =
  {
    cloud_fire_water with
    player = { cloud_fire_water.player with defense = 6 };
    ai = { cloud_fire_water.ai with defense = 6 };
  }

let cloud_water_fire =
  { volcano_water_fire with stage = "cloud kingdom" }

let cloud_water_fire_def_6 =
  {
    cloud_water_fire with
    player = { cloud_water_fire.player with defense = 6 };
    ai = { cloud_water_fire.ai with defense = 6 };
  }

let cloud_air_earth = { volcano_air_earth with stage = "cloud kingdom" }

let cloud_air_earth_def_6 =
  {
    cloud_air_earth with
    player = { cloud_air_earth.player with defense = 6 };
    ai = { cloud_air_earth.ai with defense = 6 };
  }

let cloud_earth_air = { volcano_earth_air with stage = "cloud kingdom" }

let cloud_earth_air_def_6 =
  {
    cloud_earth_air with
    player = { cloud_earth_air.player with defense = 6 };
    ai = { cloud_earth_air.ai with defense = 6 };
  }

let ocean_fire_water = { cloud_fire_water with stage = "ocean" }

let ocean_water_fire = { cloud_water_fire with stage = "ocean" }

let ocean_air_earth = { cloud_air_earth with stage = "ocean" }

let ocean_earth_air = { cloud_earth_air with stage = "ocean" }

let jungle_fire_water = { cloud_fire_water with stage = "jungle" }

let jungle_water_fire = { cloud_water_fire with stage = "jungle" }

let jungle_air_earth = { cloud_air_earth with stage = "jungle" }

let jungle_earth_air = { cloud_earth_air with stage = "jungle" }

let one_health_state =
  {
    example_state with
    player = { example_caml with hp = 1 };
    ai = { example_wolf with hp = 1 };
  }

let one_health_level_2 =
  {
    example_state with
    player = { example_caml with hp = 1; level = 2 };
    ai = { example_wolf with hp = 1; level = 2 };
  }

let volcano_fire_water_level_2 =
  {
    example_state with
    player = { example_caml with hp = 20; level = 2 };
    ai = { example_caml with hp = 20; level = 2 };
  }

let volcano_water_fire_one_health =
  {
    volcano_water_fire with
    player = { volcano_water_fire.player with hp = 1 };
    ai = { volcano_water_fire.ai with hp = 1 };
  }

let volcano_air_earth_one_health =
  {
    volcano_air_earth with
    player = { volcano_air_earth.player with hp = 1 };
    ai = { volcano_air_earth.ai with hp = 1 };
  }

let volcano_earth_air_one_health =
  {
    volcano_earth_air with
    player = { volcano_earth_air.player with hp = 1 };
    ai = { volcano_earth_air.ai with hp = 1 };
  }

let cloud_fire_water_one_health =
  {
    cloud_fire_water with
    player = { cloud_fire_water.player with hp = 1 };
    ai = { cloud_fire_water.ai with hp = 1 };
  }

let cloud_water_fire_one_health =
  {
    cloud_water_fire with
    player = { cloud_water_fire.player with hp = 1 };
    ai = { cloud_water_fire.ai with hp = 1 };
  }

let cloud_air_earth_one_health =
  {
    cloud_air_earth with
    player = { cloud_air_earth.player with hp = 1 };
    ai = { cloud_air_earth.ai with hp = 1 };
  }

let cloud_earth_air_one_health =
  {
    cloud_earth_air with
    player = { cloud_earth_air.player with hp = 1 };
    ai = { cloud_earth_air.ai with hp = 1 };
  }

(* let volcano_water_fire *)

let volcano_tests () =
  [
    (* Player fire, AI water*)
    attack_move_test "player attack. fire v water volcano no defense"
      example_state 9;
    attack_move_test "player attack. fire v water volcano 6 defense"
      volcano_fire_water_def_6 10;
    attack_move_test "player attack. fire v water volcano 0 def level 2"
      volcano_fire_water_level_2 19;
    ai_attack_test "ai attack. fire v water volcano 0 defense"
      example_state 1.0 9;
    ai_attack_test
      "ai attack. one health fire v water volcano 0 defense"
      one_health_state 2.0 0;
    (* Player Water, AI fire*)
    attack_move_test "player attack. water v fire volcano no defense"
      volcano_water_fire 9;
    attack_move_test "player attack. water v fire volcano 6 defense"
      volcano_water_fire_def_6 10;
    ai_attack_test "ai attack. water v fire volcano no defense"
      volcano_water_fire 1.0 9;
    ai_attack_test
      "ai attack. one health water v fire volcano 0 defense"
      volcano_water_fire_one_health 2.0 0;
    (* Player air, ai earth*)
    attack_move_test "player attack. air v earth volcano no defense"
      volcano_air_earth 9;
    attack_move_test "player attack. air v earth volcano 6 defense"
      volcano_air_earth_def_6 10;
    ai_attack_test "ai attack. air v earth volcano no defense"
      volcano_air_earth 1.0 9;
    ai_attack_test
      "ai attack. air v earth volcano one health no defense"
      volcano_air_earth_one_health 2.0 0;
    (* player earth, ai air*)
    attack_move_test "player attack. earth v air volcano no defense"
      volcano_earth_air 9;
    attack_move_test "player attack. earth v air volcano 6 defense"
      volcano_earth_air_def_6 10;
    ai_attack_test "ai attack. earth v air volcano no defense"
      volcano_earth_air 1.0 9;
    ai_attack_test "ai attack. earth v air volcano no defense"
      volcano_earth_air_one_health 2.0 0;
  ]

let cloud_tests () =
  [
    (* Player fire, AI water*)
    attack_move_test "player attack. fire v water cloud no defense"
      cloud_fire_water 9;
    attack_move_test "player attack. fire v water cloud 6 defense"
      cloud_fire_water_def_6 10;
    ai_attack_test "ai attack. fire v water cloud no defense"
      cloud_fire_water 1.0 9;
    ai_attack_test "ai attack. fire v water cloud one health no defense"
      cloud_fire_water_one_health 2.0 0;
    (* Player Water, AI fire*)
    attack_move_test "player attack. water v fire cloud no defense"
      cloud_water_fire 9;
    attack_move_test "player attack. water v fire cloud 6 defense"
      cloud_water_fire_def_6 10;
    ai_attack_test "ai attack. water v fire cloud no defense"
      cloud_water_fire 1.0 9;
    ai_attack_test "ai attack. water v fire cloud one health no defense"
      cloud_water_fire_one_health 2.0 0;
    (* Player air, ai earth*)
    attack_move_test "player attack. air v earth cloud no defense"
      cloud_air_earth 8;
    attack_move_test "player attack. air v earth cloud 6 defense"
      cloud_air_earth_def_6 10;
    ai_attack_test "ai attack. air v earth cloud no defense"
      cloud_air_earth 1.0 9;
    ai_attack_test "ai attack. air v earth cloud one health no defense"
      cloud_air_earth_one_health 2.0 0;
    (* player earth, ai air*)
    attack_move_test "player attack. earth v air cloud no defense"
      cloud_earth_air 9;
    attack_move_test "player attack. earth v air cloud 6 defense"
      cloud_earth_air_def_6 10;
    ai_attack_test "ai attack. earth v air cloud no defense"
      cloud_earth_air 1.0 8;
    ai_attack_test "ai attack. earth v air cloud one health no defense"
      cloud_earth_air_one_health 2.0 (-1);
  ]

let ocean_tests () =
  [
    (* Player fire, AI water*)
    attack_move_test "player attack. fire v water no defense"
      ocean_fire_water 9;
    (* Player Water, AI fire*)
    attack_move_test "player attack. water v fire ocean no defense"
      ocean_water_fire 8;
    (* Player air, ai earth*)
    attack_move_test "player attack. air v earth ocean no defense"
      ocean_air_earth 9;
    (* player earth, ai air*)
    attack_move_test "player attack. earth v air ocean no defense"
      ocean_earth_air 9;
  ]

let jungle_tests () =
  [
    (* Player fire, AI water*)
    attack_move_test "player attack. fire v water ocean no defense"
      jungle_fire_water 9;
    (* Player Water, AI fire*)
    attack_move_test "player attack. water v fire jungle"
      jungle_water_fire 9;
    (* Player air, ai earth*)
    attack_move_test "player attack. air v earth jungle"
      jungle_air_earth 9;
    (* player earth, ai air*)
    attack_move_test "player attack. earth v air jungle"
      jungle_earth_air 9;
  ]

let half_health_state =
  {
    example_state with
    player = { example_caml with hp = 5 };
    ai = { example_wolf with hp = 5 };
  }

let half_health_level_2 =
  {
    example_state with
    player = { example_caml with hp = 10; level = 2 };
    ai = { example_wolf with hp = 10; level = 2 };
  }

let defense_3_level_1 =
  {
    example_state with
    player = { example_caml with defense = 3 };
    ai = { example_wolf with defense = 3 };
  }

let defense_10_level_2 =
  {
    cloud_earth_air with
    player = { cloud_earth_air.player with defense = 10 };
    ai = { cloud_earth_air.ai with defense = 10 };
  }

let heal_tests () =
  [
    heal_test "full health heal" example_state 10;
    heal_test "half health heal level 1" half_health_state 6;
    heal_test "half health heal level 2" half_health_level_2 12;
    ai_heal_test "ai full health heal"
      (health_check 8.0 example_state)
      10;
    ai_heal_test "ai half health heal level 1"
      (health_check 8.0 half_health_state)
      6;
    ai_heal_test "ai half health heal level 2"
      (health_check 8.0 half_health_level_2)
      12;
    ai_heal_test "ai one health heal level 1"
      (health_check 5.0 one_health_state)
      2;
    ai_heal_test "ai one health heal level 2"
      (health_check 5.0 one_health_level_2)
      3;
  ]

let defense_tests () =
  [
    defense_test "level 1 caml defense"
      (move example_state example_caml example_wolf Defense true)
      2;
    defense_test "after attack defense = 0"
      (move defense_3_level_1 defense_3_level_1.ai
         defense_3_level_1.player Attack false)
      0;
    defense_test "level 2 caml defense"
      (move half_health_level_2 half_health_level_2.player
         half_health_level_2.ai Defense true)
      4;
    defense_test "after attack defense = 0 level 2"
      (move defense_10_level_2 defense_10_level_2.ai
         defense_10_level_2.player Attack false)
      0;
    ai_defense_test "ai defense level 1 enemy full health"
      (health_check 9.0 example_state)
      2;
    ai_defense_test "ai defense level 2 enemy full health"
      (health_check 9.0 volcano_fire_water_level_2)
      4;
    ai_defense_test "ai defense half health"
      (health_check 9.0 half_health_state)
      2;
    ai_defense_test "ai defense one health"
      (health_check 9.0 one_health_state)
      2;
    ai_defense_test "ai defense one health level 2"
      (health_check 9.0 one_health_level_2)
      4;
  ]

(* cloc --by-file --include-lang=OCaml . *)
let attack_test () =
  List.flatten
    [
      volcano_tests ();
      cloud_tests ();
      ocean_tests ();
      jungle_tests ();
      heal_tests ();
      defense_tests ();
    ]

let camltypes_test =
  [
    attack_multi_test "Water fire effect - weak" example_caml.element_t
      example_wolf.element_t 1.0;
    attack_multi_test "Air air effect normal"
      jungle_earth_air.ai.element_t jungle_earth_air.ai.element_t 1.25;
    attack_multi_test "Fire air effect supereffect"
      jungle_water_fire.ai.element_t jungle_earth_air.ai.element_t 1.5;
    current_hp_test "Basic health" example_caml 10;
    caml_type_test "fire caml type" example_caml "fire";
    caml_type_test "water caml state" ocean_air_earth.player "air";
    exp_update_test "Basic caml xp updated" max_xp_caml post_xp_caml;
    updated_hp_test "Basic caml damage" example_caml 1 post_damage_caml;
  ]

let debugging_tests () =
  [ (* ai_attack_test "ai attack. fire v water volcano 0 defense"
       example_state 1 1.0; attack_move_test "player attack. water v
       fire volcano no defense" volcano_water_fire 1; *) ]

let gui_test = []

let tests =
  "test suite for CamlBattle"
  >::: List.flatten
         [ camltypes_test; attack_test (); debugging_tests () ]

let _ = run_test_tt_main tests
