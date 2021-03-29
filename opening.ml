open Initstate
open Camltypes

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
  }
