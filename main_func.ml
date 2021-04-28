open Camltypes
open State
open Attack
open Ai

exception UnknownElement of string

exception UnknownCommand of string

let turn = true

(* [summary_stats] prints the summary stats of the caml at the end of
   the game.*)
let summary_stats caml =
  print_string (" Your experience gained is " ^ string_of_int caml.exp);
  print_string (" Your current level is " ^ string_of_int caml.level)

(* [end_game] prints the end of game message and prompts player to play
   again.*)
let end_game state =
  print_string " Game Over. Please select play again to\n   continue. ";
  summary_stats state.player

(* [welcome_game] prints the welcome message. *)
let welcome_game input =
  if
    input = "water" || input = "fire" || input = "air"
    || input = "earth"
  then input
  else raise (UnknownCommand input)

(* afterwards will call play_game again with state returned from attack*)

(* [user_name] prompts for the player to enter their name and prints a
   welcome message. *)

(*Initialize the caml.*)
let caml_init element =
  {
    hp = 20;
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
  | "earth" -> "air"
  | _ -> raise (UnknownElement player_element)

(* creates ai caml based on the opposite element of the player*)
let ai_caml caml_init =
  { caml_init with element_t = find_ai_element caml_init.element_t }

(*let rec valid_input () : string = let () = print_string "Select a
  valid element" in let input2 = read_line () in if input2 = "water" ||
  input2 = "fire" || input2 = "air" || input2 = "earth" then input2 else
  valid_input ()*)

let pick_biome input =
  if
    input = "volcano" || input = "ocean" || input = "jungle"
    || input = "cloud kingdom"
  then input
  else raise (UnknownCommand input)

(*change specifically for move set choice*)
(*let rec valid_input input : string = match input with | "water" |
  "fire" | "air" | "earth" | _ -> valid_input input *)
let choose_attack input =
  match input with
  | "attack" -> Attack
  | "heal" -> Heal
  | "defense" -> Defense
  | _ -> raise (UnknownCommand input)

(*let get_attack input = if input = "attack" || input = "heal" || input
  = "defense" then input else raise (UnknownCommand input) *)
let choose_move input = choose_attack input

(* [play_game state] begins the CamlBattle. Takes in the state and
   checks whether hp is below or equal to 0. Will call itself again
   based on what attack returns. *)
let rec play_game (f : State.t) =
  let check_hp = current_hp f.player in
  if check_hp <= 0 then end_game f
  else if
    f.turn
    (* will perform player attack based on move and changes turn*)
  then begin
    print_string " Your current hp is: ";
    print_endline (string_of_int check_hp);
    print_string " The opponent's hp is: ";
    print_endline (string_of_int f.ai.hp);
    print_string " AI Defense: ";
    print_endline (string_of_int f.ai.defense);
    print_endline " Select a move: attack, heal, defense ";
    let input1 = read_line () in
    play_game
      (Attack.move f f.player f.ai (choose_attack input1) f.turn)
  end
  else play_game (Ai.health_check f)

(* print_string " Select a move: attack, heal, defense for enemy "; let
   input2 = read_line () in play_game (Attack.move f f.ai f.player
   (choose_attack input2) f.turn) *)
