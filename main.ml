open Camltypes

(* [play_game] begins the CamlBattle. *)
let play_game f = failwith "Unimplemented"

let hp_update caml =
  print_string ("Your current hp is " ^ string_of_int (current_hp caml))

(* [end_game] prints the end of game message and prompts player to play
   again.*)
let rec valid_input () : string =
  let () = print_string "Select a valid element" in
  let input2 = read_line () in
  if
    input2 = "water" || input2 = "fire" || input2 = "air"
    || input2 = "earth"
  then input2
  else valid_input ()

(* [play_game] prints the welcome message. *)
let play_game () =
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
    element_t = play_game ();
    moves = [ Attack; Defense; Heal ];
    exp = 0;
    defense = 0;
    current_move = 0;
  }

let end_game () =
  print_string "Game Over. Please select play again to\n   continue."

(* [summary_stats] prints the summary stats of the caml at the end of
   the game.*)
let summary_stats caml =
  print_string ("Your experience gained is" ^ string_of_int caml.exp);
  print_string ("Your current level is" ^ string_of_int caml.level)
