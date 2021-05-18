open Camltypes
open Graphics
open State
open Attack
open Main_func
open Ai
open ANSITerminal

(* The rgb color for white*)
let white = rgb 255 255 255

(*The rgb color for blue*)
let blue = rgb 30 25 255

(*Creates the window that the graphics take place in*)
let open_window =
  open_graph " 640x480";
  set_window_title "CamlBattle"

(*Sets the background color of the window*)
let clear_window color =
  let fg = foreground in
  set_color color;
  fill_rect 0 0 (size_x ()) (size_y ());
  set_color fg

(*Draws the volcano ashes*)
let volcano_ashes () =
  Graphics.moveto 490 190;
  Graphics.draw_circle 495 215 18;
  Graphics.fill_circle 495 215 18;
  Graphics.draw_circle 520 211 12;
  Graphics.fill_circle 520 211 12;
  Graphics.draw_circle 528 226 8;
  Graphics.fill_circle 528 226 8;
  Graphics.draw_circle 503 190 17;
  Graphics.fill_circle 503 190 17;
  Graphics.draw_circle 520 233 12;
  Graphics.fill_circle 520 233 12;
  Graphics.draw_circle 535 243 10;
  Graphics.fill_circle 535 243 10

(* Draws the background of the volcano biome *)
let volcano_background () =
  clear_window (rgb 255 70 36);
  Graphics.set_color (rgb 82 39 2);
  Graphics.moveto 420 140;
  Graphics.set_line_width 2;
  Graphics.curveto (420, 140) (370, 124) (270, 0);
  Graphics.moveto 530 140;
  Graphics.curveto (530, 140) (580, 124) (680, 0);
  Graphics.moveto 480 140;
  Graphics.set_line_width 2;
  Graphics.draw_ellipse 475 140 51 10;
  Graphics.moveto 480 190;
  Graphics.set_color (rgb 169 169 169);
  Graphics.draw_circle 480 190 18;
  Graphics.fill_circle 480 190 18;
  volcano_ashes ()

(* Draws the first half of the ocean ripple. *)
let ocean_squiggle_one () =
  Graphics.moveto 328 50;
  Graphics.curveto (328, 50) (343, 70) (358, 50);
  Graphics.moveto 358 50;
  Graphics.curveto (358, 50) (373, 70) (388, 50);
  Graphics.moveto 388 50;
  Graphics.curveto (388, 50) (403, 70) (418, 50);
  Graphics.moveto 418 50;
  Graphics.curveto (418, 50) (433, 70) (448, 50);
  Graphics.moveto 448 50;
  Graphics.curveto (448, 50) (463, 70) (478, 50);
  Graphics.moveto 478 50;
  Graphics.curveto (478, 50) (493, 70) (508, 50);
  Graphics.moveto 508 50;
  Graphics.curveto (508, 50) (523, 70) (538, 50);
  Graphics.moveto 538 50;
  Graphics.curveto (538, 50) (553, 70) (568, 50);
  Graphics.moveto 568 50;
  Graphics.curveto (568, 50) (583, 70) (598, 50);
  Graphics.moveto 598 50;
  Graphics.curveto (598, 50) (613, 70) (628, 50)

(* Draws the second half of the ocean ripple. *)
let ocean_squiggle_two () =
  Graphics.moveto 628 50;
  Graphics.curveto (628, 50) (643, 70) (658, 50);
  Graphics.set_color (rgb 105 105 105);
  Graphics.moveto 448 250;
  Graphics.curveto (448, 250) (460, 270) (474, 258);
  Graphics.moveto 474 258;
  Graphics.curveto (474, 258) (486, 278) (498, 268);
  Graphics.moveto 520 200;
  Graphics.curveto (520, 200) (532, 220) (544, 208);
  Graphics.moveto 544 208;
  Graphics.curveto (544, 208) (556, 228) (568, 218)

(* Draws the background of the ocean biome *)
let ocean_background () =
  clear_window (rgb 0 206 209);
  Graphics.set_color (rgb 0 0 139);
  Graphics.set_line_width 2;
  Graphics.moveto 0 50;
  Graphics.curveto (0, 50) (15, 70) (30, 50);
  Graphics.moveto 30 50;
  Graphics.curveto (30, 50) (45, 70) (60, 50);
  Graphics.moveto 178 50;
  Graphics.curveto (178, 50) (193, 70) (208, 50);
  Graphics.moveto 208 50;
  Graphics.curveto (208, 50) (223, 70) (238, 50);
  Graphics.moveto 238 50;
  Graphics.curveto (238, 50) (253, 70) (268, 50);
  Graphics.moveto 268 50;
  Graphics.curveto (268, 50) (283, 70) (298, 50);
  Graphics.moveto 298 50;
  Graphics.curveto (298, 50) (313, 70) (328, 50);
  ocean_squiggle_one ();
  ocean_squiggle_two ()

(* Draws the background of the jungle biome *)
let jungle_background () =
  clear_window (rgb 46 139 87);
  Graphics.set_color (rgb 120 48 48);
  Graphics.set_line_width 2;
  Graphics.moveto 448 0;
  Graphics.curveto (448, 0) (480, 110) (448, 220);
  Graphics.moveto 580 0;
  Graphics.curveto (580, 0) (548, 110) (580, 220);
  Graphics.set_color (rgb 40 168 77);
  Graphics.moveto 445 200;
  Graphics.curveto (445, 200) (415, 225) (445, 250);
  Graphics.moveto 445 250;
  Graphics.curveto (445, 250) (450, 300) (490, 280);
  Graphics.moveto 490 280;
  Graphics.curveto (490, 280) (530, 330) (550, 280);
  Graphics.moveto 550 280;
  Graphics.curveto (550, 280) (590, 300) (580, 260);
  Graphics.moveto 580 260;
  Graphics.curveto (580, 260) (625, 230) (580, 195)

(* Draws the first cloud in the cloud_kingdom biome*)
let first_cloud () =
  Graphics.moveto 350 60;
  Graphics.draw_circle 355 60 18;
  Graphics.fill_circle 355 60 18;
  Graphics.draw_circle 365 82 18;
  Graphics.fill_circle 365 82 18;
  Graphics.draw_circle 390 90 19;
  Graphics.fill_circle 390 90 19;
  Graphics.draw_circle 410 80 18;
  Graphics.fill_circle 410 80 18;
  Graphics.draw_circle 415 55 17;
  Graphics.fill_circle 415 55 17;
  Graphics.draw_circle 383 47 22;
  Graphics.fill_circle 383 47 22;
  Graphics.draw_circle 383 65 17;
  Graphics.fill_circle 383 65 17

(* Draws the second cloud in the cloud_kingdom biome*)
let second_cloud () =
  Graphics.moveto 520 60;
  Graphics.draw_circle 528 60 15;
  Graphics.fill_circle 528 60 15;
  Graphics.draw_circle 540 82 16;
  Graphics.fill_circle 540 82 16;
  Graphics.draw_circle 560 90 16;
  Graphics.fill_circle 560 90 16;
  Graphics.draw_circle 580 80 15;
  Graphics.fill_circle 580 80 15;
  Graphics.draw_circle 580 55 14;
  Graphics.fill_circle 580 55 14;
  Graphics.draw_circle 553 47 22;
  Graphics.fill_circle 553 47 22;
  Graphics.draw_circle 560 65 14;
  Graphics.fill_circle 560 65 14

(* Draws the background of the cloud_kingdom biome *)
let cloud_kingdom_background () =
  clear_window (rgb 255 255 0);
  Graphics.set_color (rgb 0 247 255);
  Graphics.moveto 420 220;
  Graphics.draw_circle 425 220 18;
  Graphics.fill_circle 425 220 18;
  Graphics.draw_circle 435 242 18;
  Graphics.fill_circle 435 242 18;
  Graphics.draw_circle 460 250 19;
  Graphics.fill_circle 460 250 19;
  Graphics.draw_circle 480 240 18;
  Graphics.fill_circle 480 240 18;
  Graphics.draw_circle 485 215 17;
  Graphics.fill_circle 485 215 17;
  Graphics.draw_circle 453 207 22;
  Graphics.fill_circle 453 207 22;
  Graphics.draw_circle 453 225 17;
  Graphics.fill_circle 453 225 17;
  first_cloud ();
  second_cloud ()

(*Matches the background with the corresponding stage biome*)
let match_environment stage =
  match stage with
  | "volcano" -> volcano_background ()
  | "ocean" -> ocean_background ()
  | "jungle" -> jungle_background ()
  | "cloud kingdom" -> cloud_kingdom_background ()
  | _ -> failwith "Not valid"

(*Matches the camel color with the camel element*)
let camel_type caml =
  match caml with
  | "water" -> rgb 115 255 246
  | "air" -> rgb 255 255 232
  | "fire" -> rgb 245 139 139
  | "earth" -> rgb 120 255 179
  | _ -> failwith "Not valid"

(*Draws the back_leg of the camel*)
let back_leg () =
  Graphics.moveto 87 55;
  Graphics.lineto 74 10;
  Graphics.moveto 101 40;
  Graphics.lineto 92 10

(*Draws the front leg of the camel*)
let front_leg () =
  Graphics.moveto 161 55;
  Graphics.lineto 170 10;
  Graphics.moveto 172 55;
  Graphics.lineto 190 10;
  Graphics.moveto 110 65;
  Graphics.draw_circle 70 60 10;
  Graphics.fill_circle 70 60 10

(*Draws the caml body*)
let caml_body color =
  Graphics.moveto 283 124;
  Graphics.set_color (rgb 0 0 0);
  Graphics.draw_circle 283 124 5;
  Graphics.fill_circle 283 124 5;
  Graphics.set_color (rgb 250 75 75);
  Graphics.moveto 290 107;
  Graphics.draw_ellipse 290 107 7 2;
  Graphics.fill_ellipse 290 107 7 2;
  Graphics.set_color color;
  Graphics.set_line_width 5

(*Draws the camel onto the screen*)
let draw_user_caml color =
  Graphics.set_color color;
  Graphics.draw_ellipse 150 100 40 60;
  Graphics.fill_ellipse 150 100 40 60;
  Graphics.draw_ellipse 100 100 40 60;
  Graphics.fill_ellipse 100 100 40 60;
  Graphics.moveto 180 120;
  Graphics.set_line_width 20;
  Graphics.curveto (180, 120) (220, 60) (260, 120);
  Graphics.moveto 260 120;
  Graphics.draw_circle 280 120 15;
  Graphics.fill_circle 280 120 15;
  Graphics.set_line_width 1;
  caml_body color;
  back_leg ();
  front_leg ()

(* Draws the enemy element*)
let draw_enemy color =
  Graphics.set_color color;
  Graphics.draw_circle 500 400 50;
  Graphics.fill_circle 500 400 50;
  Graphics.set_line_width 2;
  Graphics.set_color (rgb 0 0 0);
  Graphics.moveto 465 420;
  Graphics.lineto 488 400;
  Graphics.moveto 530 420;
  Graphics.lineto 507 400;
  Graphics.draw_circle 485 398 4;
  Graphics.fill_circle 485 398 4;
  Graphics.draw_circle 510 398 4;
  Graphics.fill_circle 510 398 4;
  Graphics.moveto 480 370;
  Graphics.curveto (480, 370) (495, 388) (514, 370)

(*Draws the current stats of the user*)
let user_board color (state : State.t) =
  Graphics.set_color color;
  Graphics.draw_rect 230 170 60 90;
  Graphics.fill_rect 230 170 60 90;
  Graphics.moveto 240 240;
  Graphics.set_color Graphics.black;
  Graphics.draw_string ("Exp: " ^ string_of_int state.player.exp);
  Graphics.moveto 240 210;
  Graphics.set_color Graphics.black;
  Graphics.draw_string ("Lv: " ^ string_of_int state.player.level);
  Graphics.moveto 240 180;
  Graphics.set_color Graphics.black;
  Graphics.draw_string
    ("HP: " ^ string_of_int (Camltypes.current_hp state.player))

(*Draws the current stats of the enemy*)
let enemy_board color (state : State.t) =
  Graphics.set_color color;
  Graphics.draw_rect 350 370 60 90;
  Graphics.fill_rect 350 370 60 90;
  Graphics.moveto 360 440;
  Graphics.set_color Graphics.black;
  Graphics.draw_string ("Exp: " ^ string_of_int state.ai.exp);
  Graphics.moveto 360 410;
  Graphics.set_color Graphics.black;
  Graphics.draw_string ("Lv: " ^ string_of_int state.ai.level);
  Graphics.moveto 360 380;
  Graphics.set_color Graphics.black;
  Graphics.draw_string
    ("HP: " ^ string_of_int (Camltypes.current_hp state.ai))

(* Updates the moves in terminal*)
let move_update state =
  ANSITerminal.print_string [ on_default ] " Your current hp is: ";
  print_endline (string_of_int (Camltypes.current_hp state.player));
  ANSITerminal.print_string [ on_default ] " The opponent's hp is: ";
  print_endline (string_of_int state.ai.hp);
  ANSITerminal.print_string [ on_default ] " AI Defense: ";
  print_endline (string_of_int state.ai.defense)

(* Draws the menu for choosing the moves*)
let drawing_menu state =
  Graphics.set_color Graphics.white;
  Graphics.draw_rect 50 370 150 80;
  Graphics.fill_rect 50 370 150 80;
  Graphics.moveto 70 430;
  Graphics.set_color Graphics.black;
  Graphics.draw_string "Press a to attack";
  Graphics.moveto 70 405;
  Graphics.set_color Graphics.black;
  Graphics.draw_string "Press s for heal";
  Graphics.moveto 70 380;
  Graphics.set_color Graphics.black;
  Graphics.draw_string "Press d for defend"

(* Draws the welcome message on the screen *)
let rec render_welcome (state : State.t) =
  Graphics.clear_graph ();
  Graphics.moveto 200 200;
  Graphics.set_color Graphics.black;
  Graphics.set_text_size 100;
  Graphics.draw_string "Welcome to CamlBattles! Press s to start";
  let event = wait_next_event [ Key_pressed ] in
  if event.key == 's' then () else render_welcome state

(*Keeps track of the moves and the player health*)
let moves_state state =
  drawing_menu state;
  move_update state;
  let event = wait_next_event [ Key_pressed ] in
  match event.key with
  | 's' ->
      Attack.move state state.player state.ai Heal true
      |> Ai.health_check (Random.float 10.0)
  | 'a' ->
      Attack.move state state.player state.ai Attack true
      |> Ai.health_check (Random.float 10.0)
  | 'd' ->
      Attack.move state state.player state.ai Defense true
      |> Ai.health_check (Random.float 10.0)
  | _ -> failwith "not right key"

(*Displays the messages for choosing the cameltypes*)
let rec render_choose_type (state : State.t) =
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
  if event.key == 'q' then
    { state with player = { state.player with element_t = "fire" } }
  else if event.key == 'w' then
    { state with player = { state.player with element_t = "water" } }
  else if event.key == 'e' then
    { state with player = { state.player with element_t = "earth" } }
  else if event.key == 'r' then
    { state with player = { state.player with element_t = "air" } }
  else render_choose_type state

(* Displays the messages for choosing the biome*)
let rec render_choose_biome (state : State.t) =
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
  else render_choose_biome state

(*colors caml and renders on page*)

let rec render_game (state : State.t) : unit =
  Graphics.clear_graph ();
  Graphics.set_color Graphics.black;
  match_environment state.stage;
  let check_player_hp = Camltypes.current_hp state.player in
  let check_ai_hp = Camltypes.current_hp state.ai in
  if check_player_hp <= 0 then
    ANSITerminal.print_string [ on_default ] "hp is less than 0 player"
  else if check_ai_hp <= 0 then
    ANSITerminal.print_string [ on_default ] "hp is less than 0 AI"
  else (
    user_board white state;
    enemy_board white state;
    draw_user_caml (camel_type state.player.element_t);
    draw_enemy (camel_type state.ai.element_t);
    let new_state = moves_state state in
    render_game new_state)

let updated_state (state : State.t) =
  { state with player = Camltypes.exp_update state.player }

let rec render_closing (state : State.t) =
  Graphics.clear_graph ();
  let check_player_hp = Camltypes.current_hp state.player in
  let check_ai_hp = Camltypes.current_hp state.ai in
  if check_player_hp <= 0 then Graphics.moveto 50 200;
  Graphics.set_color Graphics.black;
  Graphics.set_text_size 100;
  Graphics.draw_string "Game Over. Press s to start another game";
  Graphics.moveto 50 150;
  Graphics.set_color Graphics.black;
  Graphics.set_text_size 100;
  Graphics.draw_string "Press q to quit";
  let event = wait_next_event [ Key_pressed ] in
  if event.key == 's' then render_game (updated_state state)
  else if event.key == 'q' then close_graph ()
  else render_closing state;
  if check_ai_hp <= 0 then Graphics.moveto 50 200;
  Graphics.set_color Graphics.black;
  Graphics.set_text_size 100;
  Graphics.draw_string "You won! Press s to to start another game";
  Graphics.moveto 50 200;
  Graphics.set_color Graphics.black;
  Graphics.set_text_size 100;
  Graphics.moveto 50 150;
  Graphics.set_color Graphics.black;
  Graphics.set_text_size 100;
  Graphics.draw_string "Press q to quit";
  let event = wait_next_event [ Key_pressed ] in
  if event.key == 's' then render_game (updated_state state)
  else if event.key == 'q' then close_graph ()
  else render_closing state

(* let render_name = Graphics.set_color Graphics.black;
   Graphics.draw_string "Please enter your name."; input_name () *)

(* Graphics.set_text_size 30; Graphics.draw_string "Welcome to
   CamlBattles! Please select from fire, water, air, or \ earth.";
   input_name () *)

(*let render_background (state : State.t) = let () = open_window in let
  () = render_welcome state in let type_state = render_choose_type state
  in let chosen_state = render_choose_biome type_state in let () =
  render_game chosen_state in render_closing state*)

(* let r, g, b = color_to_rgb background in Printf.printf "Background
   color: %d %d %d\n" r g b *)
