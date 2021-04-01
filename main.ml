open Camltypes
open State
open Attack

exception UnknownElement of string

exception UnknownCommand of string

let turn = true

(*change specifically for move set choice*)
let rec valid_input () : string =
  let () = print_string "Select a valid element" in
  let input2 = read_line () in
  if
    input2 = "water" || input2 = "fire" || input2 = "air"
    || input2 = "earth"
  then input2
  else valid_input ()

let choose_attack input =
  match input with
  | "attack" -> Attack
  | "heal" -> Heal
  | "defense" -> Defense
  | _ -> raise (UnknownCommand input)

let get_attack =
  let () = print_string "Select a move: attack, heal, defense" in
  let input = read_line () in
  if input = "attack" || input = "heal" || input = "defense" then input
  else valid_input ()

let player_move = choose_attack get_attack

let ai_move = choose_attack get_attack

(* [summary_stats] prints the summary stats of the caml at the end of
   the game.*)
let summary_stats caml =
  print_string ("Your experience gained is" ^ string_of_int caml.exp);
  print_string ("Your current level is" ^ string_of_int caml.level)

(* [end_game] prints the end of game message and prompts player to play
   again.*)
let end_game state =
  print_string "Game Over. Please select play again to\n   continue.";
  summary_stats state.player

(* [welcome_game] prints the welcome message. *)
let welcome_game =
  let () =
    print_string
      "Hello! Welcome to CamlBattles. Please select your element: \
       fire, water, air, or earth"
  in
  let input = read_line () in
  if
    input = "water" || input = "fire" || input = "air"
    || input = "earth"
  then input
  else valid_input ()

(* [play_game state] begins the CamlBattle. Takes in the state and
   checks whether hp is below or equal to 0. Will call itself again
   based on what attack returns. *)
let rec play_game (f : State.t) =
  let check_hp = current_hp f.player in
  if check_hp <= 0 then end_game f
  else if
    turn (* will perform player attack based on move and changes turn*)
  then
    let chosen_move = choose_attack get_attack in
    play_game (Attack.move f f.player f.ai chosen_move turn)
  else
    play_game
      (Attack.move f f.ai f.player (choose_attack get_attack) turn)

(* afterwards will call play_game again with state returned from attack*)

(* [user_name] prompts for the player to enter their name and prints a
   welcome message. *)
let user_name =
  let () = print_string "Please enter your name." in
  let name = read_line () in
  if String.length name <= 0 then
    print_string "Name has to be more than 1 character."
  else print_string ("Welcome" ^ name)

(*Initialize the caml.*)
let caml_init element =
  {
    hp = 10;
    level = 1;
    element_t = element;
    moves = [ Attack; Defense; Heal ];
    exp = 0;
    defense = 0;
    current_move = 0;
  }

(* add end of file*)
let find_ai_element player_element =
  match player_element with
  | "fire" -> "water"
  | "water" -> "earth"
  | "air" -> "fire"
  | "earth" -> "fire"
  | _ -> raise (UnknownElement player_element)

(* creates ai caml based on the opposite element of the player*)

let ai_caml element caml_init =
  { caml_init with element_t = find_ai_element element }

let rec valid_input () : string =
  let () = print_string "Select a valid element" in
  let input2 = read_line () in
  if
    input2 = "water" || input2 = "fire" || input2 = "air"
    || input2 = "earth"
  then input2
  else valid_input ()

let pick_biome =
  let () =
    print_string
      "Please choose your biome. You can choose from volcano, ocean, \
       jungle, cloud kingdom. Note: your biome can affect your attack \
       power."
  in
  let input = read_line () in
  if
    input = "volcano" || input = "ocean" || input = "jungle"
    || input = "cloud kingdom"
  then input
  else valid_input ()

(* [main] First prompts user for username. Afterwards, prints welcome
   message and then asks user for element and biome. Then, initliazes
   player and AI camls. Calls play_game with new constructed state.t
   element from player and AI camls. *)
let main () =
  let () = user_name in
  let player_caml = caml_init welcome_game in
  let enemy_caml = ai_caml welcome_game player_caml in
  let player_stage = pick_biome in
  let game_state =
    {
      player = player_caml;
      ai = enemy_caml;
      stage = player_stage;
      turn = true;
    }
  in
  play_game game_state

let hp_update caml =
  print_string ("Your current hp is " ^ string_of_int (current_hp caml))

let () = main ()
