open Initstate
open Camltypes

(* [play_game] prints the welcome message. *)
let play_game =
  print_string
    "Hello! Welcome to CamlBattles. Please select your element: fire, \
     water, air, or earth"

(* [user_name] prompts for the player to enter their name. *)
let user_name = print_string "Please enter your name."

(* [element] prints the welcome message along with the player name. *)
let element =
  play_game;
  user_name;
  match read_line () with
  | exception End_of_file ->
      print_string "Name has to be more than 1 character.";
      "Name has to be more than 1 character."
  | name ->
      print_newline ();
      print_string ("Welcome" ^ name);
      "Welcome" ^ name