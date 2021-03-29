open Camltypes

(* [play_game] begins the CamlBattle. *)
let play_game f = failwith "Unimplemented"

let hp_update caml =
  print_string ("Your current hp is " ^ string_of_int (current_hp caml))

(* [end_game] prints the end of game message and prompts player to play
   again.*)
let end_game () =
  print_string "Game Over. Please select play again to\n   continue."

(* [summary_stats] prints the summary stats of the caml at the end of
   the game.*)
let summary_stats caml =
  print_string ("Your experience gained is" ^ string_of_int caml.exp);
  print_string ("Your current level is" ^ string_of_int caml.level)
