open Camltypes
open State
open Attack
open Main_func
open Draw
open Graphics

let turn = true

(*Displays the messages for choosing the cameltypes*)
let rec render_choose_type () =
  Graphics.clear_graph ();
  Graphics.moveto 200 300;
  Graphics.set_color Graphics.black;
  Graphics.set_text_size 150;
  Graphics.draw_string "Please choose your CamlType!";
  Graphics.set_text_size 100;
  Graphics.moveto 200 270;
  Graphics.draw_string "Press Q for Fire!";
  Graphics.moveto 200 240;
  Graphics.draw_string "Press W for Water!";
  Graphics.moveto 200 210;
  Graphics.draw_string "Press E for Earth!";
  Graphics.moveto 200 180;
  Graphics.draw_string "Press R for Air!";
  let event = wait_next_event [ Key_pressed ] in
  if event.key == 'q' then "fire"
  else if event.key == 'w' then "water"
  else if event.key == 'e' then "earth"
  else if event.key == 'r' then "air"
  else render_choose_type ()

(* Displays the messages for choosing the biome*)
let rec render_choose_biome () =
  Graphics.clear_graph ();
  Graphics.moveto 200 300;
  Graphics.set_color Graphics.black;
  Graphics.set_text_size 150;
  Graphics.draw_string "Please choose your Biome!";
  Graphics.set_text_size 100;
  Graphics.moveto 200 270;
  Graphics.draw_string "Press Q for Volcano!";
  Graphics.moveto 200 240;
  Graphics.draw_string "Press W for Ocean!";
  Graphics.moveto 200 210;
  Graphics.draw_string "Press E for Jungle!";
  Graphics.moveto 200 180;
  Graphics.draw_string "Press R for Cloud Kingdom!";
  let event = wait_next_event [ Key_pressed ] in
  if event.key == 'q' then "volcano"
  else if event.key == 'w' then "ocean"
  else if event.key == 'e' then "jungle"
  else if event.key == 'r' then "cloud kingdom"
  else render_choose_biome ()

(*Creates the window that the graphics take place in*)
let open_window =
  open_graph " 640x480";
  set_window_title "CamlBattle"

(* [main] First prompts user for username. Afterwards, prints welcome
   message and then asks user for element and biome. Then, initliazes
   player and AI camls. Calls play_game with new constructed state.t
   element from player and AI camls. *)
let main () =
  let () = open_window in
  let chosen_type = render_choose_type () in
  let chosen_biome = render_choose_biome () in
  let player_caml = caml_init chosen_type in
  let enemy_caml = ai_caml player_caml in
  let game_state =
    {
      player = player_caml;
      ai = enemy_caml;
      stage = chosen_biome;
      turn = true;
    }
  in
  let () = render_welcome game_state in
  let () = render_game game_state in
  render_closing game_state

(* print_string " Please enter your name "; let name = read_line () in
   if String.length name <= 0 then print_string "Name has to be more
   than 1 character " else print_string ("Welcome " ^ name ^ " to
   CamlBattles!"); print_string " Please select from fire, water, air,
   or earth "; let input_player_el = read_line () in let player_caml =
   caml_init (welcome_game input_player_el) in let enemy_caml = ai_caml
   player_caml in let player_stage = let () = print_string " Please
   choose from volcano, ocean, jungle, cloud kingdom. \ Note: your biome
   can affect your attack power " in let input_biome = read_line () in
   pick_biome input_biome in let game_state = { player = player_caml; ai
   = enemy_caml; stage = player_stage; turn = true; } in
   Main_func.play_game game_state

   let hp_update caml = print_string ("Your current hp is " ^
   string_of_int (current_hp caml))*)

let () = main ()
