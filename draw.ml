open Camltypes
open Graphics
open State
open Attack
open Main_func
open Ai
open ANSITerminal

(*Creates the window that the graphics take place in*)
let open_window =
  open_graph " 640x480";
  set_window_title "CamlBattle"

(*Sets the background color of the window by drawing a rectangle the
  size of the window*)
let color_background color =
  let () = Graphics.set_color color in
  let () = Graphics.fill_rect 0 0 640 480 in
  Graphics.set_color foreground

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
  color_background (rgb 255 70 36);
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
  color_background (rgb 0 206 209);
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

(*[draw_apple] draws the apple of the tree in the jungle biome *)
let draw_apple () =
  Graphics.set_color (rgb 255 19 12);
  Graphics.draw_circle 520 210 15;
  Graphics.set_color (rgb 120 48 48);
  Graphics.set_line_width 2;
  Graphics.moveto 513 214;
  Graphics.curveto (513, 214) (520, 207) (527, 214);
  Graphics.moveto 520 210;
  Graphics.curveto (520, 210) (516, 217) (526, 226)

(* Draws the background of the jungle biome *)
let jungle_background () =
  color_background (rgb 46 139 87);
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
  Graphics.curveto (580, 260) (625, 230) (580, 195);
  draw_apple ()

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

(* Draws the third cloud in the cloud_kingdom biome*)
let third_cloud () =
  Graphics.moveto 520 150;
  Graphics.draw_circle 533 150 12;
  Graphics.fill_circle 533 150 12;
  Graphics.draw_circle 540 168 13;
  Graphics.fill_circle 540 168 13;
  Graphics.draw_circle 560 180 13;
  Graphics.fill_circle 560 180 13;
  Graphics.draw_circle 580 170 12;
  Graphics.fill_circle 580 170 12;
  Graphics.draw_circle 580 145 13;
  Graphics.fill_circle 580 145 13;
  Graphics.draw_circle 557 138 18;
  Graphics.fill_circle 557 138 18;
  Graphics.draw_circle 560 155 16;
  Graphics.fill_circle 560 155 16

(* Draws the fourth cloud in the cloud_kingdom biome*)
let fourth_cloud () =
  Graphics.moveto 100 220;
  Graphics.draw_circle 105 220 18;
  Graphics.fill_circle 105 220 18;
  Graphics.draw_circle 115 242 18;
  Graphics.fill_circle 115 242 18;
  Graphics.draw_circle 140 250 19;
  Graphics.fill_circle 140 250 19;
  Graphics.draw_circle 160 240 18;
  Graphics.fill_circle 160 240 18;
  Graphics.draw_circle 165 215 17;
  Graphics.fill_circle 165 215 17;
  Graphics.draw_circle 133 207 22;
  Graphics.fill_circle 133 207 22;
  Graphics.draw_circle 133 225 17;
  Graphics.fill_circle 133 225 17

(* Draws the fifth cloud in the cloud_kingdom biome*)
let fifth_cloud () =
  Graphics.moveto 50 280;
  Graphics.draw_circle 50 280 12;
  Graphics.fill_circle 50 280 12;
  Graphics.draw_circle 57 298 13;
  Graphics.fill_circle 57 298 13;
  Graphics.draw_circle 77 310 13;
  Graphics.fill_circle 77 310 13;
  Graphics.draw_circle 97 300 12;
  Graphics.fill_circle 97 300 12;
  Graphics.draw_circle 97 275 13;
  Graphics.fill_circle 97 275 13;
  Graphics.draw_circle 74 268 18;
  Graphics.fill_circle 74 268 18;
  Graphics.draw_circle 77 285 16;
  Graphics.fill_circle 77 285 16

(* Draws the sixth cloud in the cloud_kingdom biome*)
let sixth_cloud () =
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
  Graphics.fill_circle 453 225 17

(* Draws the background of the cloud_kingdom biome *)
let cloud_kingdom_background () =
  color_background (rgb 255 255 0);
  Graphics.set_color (rgb 0 247 255);
  first_cloud ();
  second_cloud ();
  third_cloud ();
  fourth_cloud ();
  fifth_cloud ();
  sixth_cloud ()

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
  Graphics.lineto 92 10;
  Graphics.set_color (rgb 93 49 48);
  Graphics.draw_ellipse 74 9 4 2;
  Graphics.draw_ellipse 92 9 4 2

(*Draws the front leg of the camel*)
let front_leg color =
  Graphics.set_color color;
  Graphics.moveto 161 55;
  Graphics.lineto 170 10;
  Graphics.moveto 172 55;
  Graphics.lineto 190 10;
  Graphics.moveto 110 65;
  Graphics.draw_circle 70 60 10;
  Graphics.fill_circle 70 60 10;
  Graphics.set_color (rgb 93 49 48);
  Graphics.draw_ellipse 190 9 4 2;
  Graphics.draw_ellipse 170 9 4 2

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

(*Draws the caml hat.*)
let caml_hat () =
  Graphics.set_color (rgb 117 220 253);
  Graphics.draw_rect 275 160 13 13;
  Graphics.fill_rect 275 160 13 13;
  Graphics.draw_rect 265 147 32 8;
  Graphics.fill_rect 265 147 32 8

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
  front_leg color;
  caml_hat ()

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
  Graphics.draw_rect 230 190 60 90;
  Graphics.fill_rect 230 190 60 90;
  Graphics.moveto 240 260;
  Graphics.set_color Graphics.black;
  Graphics.draw_string ("Exp: " ^ string_of_int state.player.exp);
  Graphics.moveto 240 230;
  Graphics.set_color Graphics.black;
  Graphics.draw_string ("Lv: " ^ string_of_int state.player.level);
  Graphics.moveto 240 200;
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

(* [moves_update] updates the moves in terminal*)
let move_update state =
  ANSITerminal.print_string [ on_default ] " Your current hp is: ";
  print_endline (string_of_int (Camltypes.current_hp state.player));
  ANSITerminal.print_string [ on_default ] " The opponent's hp is: ";
  print_endline (string_of_int state.ai.hp);
  ANSITerminal.print_string [ on_default ] " AI Defense: ";
  print_endline (string_of_int state.ai.defense)

(* [drawing_menu] draws the menu for choosing the moves*)
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

(* [render_welcome] draws the welcome message on the screen *)
let rec render_welcome () =
  Graphics.clear_graph ();
  Graphics.set_color (rgb 249 138 56);
  Graphics.draw_rect 0 0 640 100;
  Graphics.fill_rect 0 0 640 100;
  Graphics.set_color (rgb 9 16 201);
  Graphics.draw_rect 0 100 640 500;
  Graphics.fill_rect 0 100 640 500;
  draw_user_caml (rgb 254 226 100);
  Graphics.set_color Graphics.white;
  Graphics.draw_circle 100 300 0;
  Graphics.fill_circle 100 300 0;
  Graphics.set_text_size 100;
  Graphics.moveto 200 250;
  Graphics.draw_string "Welcome to CamlBattles! Press s to start";
  let event = wait_next_event [ Key_pressed ] in
  if event.key == 's' then () else render_welcome ()

(*[moves_state] takes in and keeps track of the moves and the player
  health*)
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

(* [background_design] draws the background of the type choosing screen. *)
let background_design () =
  Graphics.set_color (rgb 178 226 255);
  Graphics.set_line_width 1;
  Graphics.draw_rect 0 0 640 480;
  Graphics.fill_rect 0 0 640 480;
  Graphics.moveto 240 300;
  Graphics.set_color Graphics.black;
  Graphics.draw_rect 220 160 200 170

(*Displays the messages for choosing the cameltypes*)
let rec render_choose_type () =
  Graphics.clear_graph ();
  background_design ();
  Graphics.draw_string "Please choose your CamlType!";
  Graphics.set_text_size 100;
  Graphics.moveto 260 270;
  Graphics.set_color Graphics.black;
  Graphics.draw_string "Press Q for ";
  Graphics.moveto 330 270;
  Graphics.set_color Graphics.red;
  Graphics.draw_string "Fire!";
  Graphics.moveto 260 240;
  Graphics.set_color Graphics.black;
  Graphics.draw_string "Press W for ";
  Graphics.moveto 330 240;
  Graphics.set_color Graphics.blue;
  Graphics.draw_string "Water!";
  Graphics.set_color Graphics.black;
  Graphics.moveto 260 210;
  Graphics.draw_string "Press E for ";
  Graphics.moveto 330 210;
  Graphics.set_color Graphics.green;
  Graphics.draw_string "Earth!";
  Graphics.moveto 260 180;
  Graphics.set_color Graphics.black;
  Graphics.draw_string "Press R for ";
  Graphics.moveto 330 180;
  Graphics.set_color Graphics.yellow;
  Graphics.draw_string "Air!";
  let event = wait_next_event [ Key_pressed ] in
  if event.key == 'q' then "fire"
  else if event.key == 'w' then "water"
  else if event.key == 'e' then "earth"
  else if event.key == 'r' then "air"
  else render_choose_type ()

(* Displays the messages for choosing the biome*)
let rec render_choose_biome () =
  Graphics.clear_graph ();
  background_design ();
  Graphics.draw_string "Please choose your Biome!";
  Graphics.set_text_size 100;
  Graphics.moveto 260 270;
  Graphics.set_color Graphics.black;
  Graphics.draw_string "Press Q for ";
  Graphics.moveto 330 270;
  Graphics.set_color Graphics.red;
  Graphics.draw_string "Volcano!";
  Graphics.moveto 260 240;
  Graphics.set_color Graphics.black;
  Graphics.draw_string "Press W for ";
  Graphics.moveto 330 240;
  Graphics.set_color Graphics.blue;
  Graphics.draw_string "Ocean!";
  Graphics.set_color Graphics.black;
  Graphics.moveto 260 210;
  Graphics.draw_string "Press E for ";
  Graphics.moveto 330 210;
  Graphics.set_color Graphics.green;
  Graphics.draw_string "Jungle!";
  Graphics.moveto 260 180;
  Graphics.set_color Graphics.black;
  Graphics.draw_string "Press R for ";
  Graphics.moveto 330 180;
  Graphics.set_color Graphics.yellow;
  Graphics.draw_string "Cloud Kingdom!";
  let event = wait_next_event [ Key_pressed ] in
  if event.key == 'q' then "volcano"
  else if event.key == 'w' then "ocean"
  else if event.key == 'e' then "jungle"
  else if event.key == 'r' then "cloud kingdom"
  else render_choose_biome ()

(* [update_lost_state] returns the state when the user has lost*)
let update_lost_state state =
  {
    state with
    player = caml_init state.player.element_t;
    ai = caml_init state.ai.element_t;
  }

(* [update_won_state] returns the state when the user has won*)
let update_won_state state =
  {
    state with
    player = Camltypes.exp_update state.player;
    ai = Camltypes.exp_update state.ai;
  }

(* [true_close] draws the final closing screen of the game*)
let rec true_close final_state =
  Graphics.clear_graph ();
  Graphics.moveto 175 300;
  Graphics.set_color Graphics.black;
  Graphics.set_text_size 100;
  Graphics.draw_string
    ("Thanks for playing! You got to level: "
    ^ string_of_int final_state.player.level
    ^ " Nice Job!");
  Graphics.moveto 250 200;
  Graphics.draw_string "Press q again to exit";

  let event = wait_next_event [ Key_pressed ] in
  if event.key == 'q' then close_graph () else true_close final_state

(* [player_lost]Draws the screen in the case that the player has lost*)
let player_lost () =
  Graphics.clear_graph ();
  Graphics.moveto 100 200;
  Graphics.set_color Graphics.black;
  Graphics.draw_string
    "Game Over. Press s to start another game. Press q to quit."

(* [player_won] Draws the screen in the case that the player has won*)
let player_won () =
  Graphics.clear_graph ();
  Graphics.moveto 100 200;
  Graphics.set_color Graphics.black;
  Graphics.draw_string
    "You won! Press s to to start another game. Press q to quit"

(* [draw_boxes] Draws the boxes and dialogue in the gotcha game*)
let draw_boxes () =
  Graphics.clear_graph ();
  Graphics.moveto 100 400;
  Graphics.set_color Graphics.black;
  Graphics.set_text_size 100;
  Graphics.draw_string
    "Please pick from the three boxes below for a prize in your efforts";
  Graphics.moveto 100 300;
  Graphics.draw_string
    "Please press the key denoted by the letter above the box";
  Graphics.moveto 125 250;
  Graphics.draw_string "c";
  Graphics.fill_rect 100 200 50 50;
  Graphics.moveto 225 250;
  Graphics.draw_string "v";
  Graphics.fill_rect 200 200 50 50;
  Graphics.moveto 325 250;
  Graphics.draw_string "b";
  Graphics.fill_rect 300 200 50 50

let correcting_state state good_result =
  match good_result with
  | true ->
      {
        state with
        player =
          {
            state.player with
            hp = state.player.hp - (1 * (state.player.hp / 10));
          };
      }
  | false ->
      {
        state with
        player =
          {
            state.player with
            hp = state.player.hp + (1 * (state.player.hp / 10));
          };
      }

let rec player_gotcha_msgs result =
  Graphics.clear_graph ();
  Graphics.moveto 200 300;
  Graphics.set_color Graphics.black;
  match result with
  | 0 ->
      Graphics.draw_string
        "You've chosen wisely. Take this extra boost to help you in \
         battle. Please press s to start";
      let event = wait_next_event [ Key_pressed ] in
      if event.key == 's' then () else player_gotcha_msgs result
  | 1 ->
      Graphics.draw_string
        "A Bomb explodes. You suffer a hit to your HP. Please press s \
         to start";
      let event = wait_next_event [ Key_pressed ] in
      if event.key == 's' then () else player_gotcha_msgs result
  | 2 ->
      Graphics.draw_string
        "You avoided the bomb. Prepare for battle! Please press s to \
         start";
      let event = wait_next_event [ Key_pressed ] in
      if event.key == 's' then () else player_gotcha_msgs result

let winning_box chosen_char state =
  let random_int = Random.int 3 in
  match chosen_char with
  | 'c' ->
      if random_int == 0 || random_int == 1 then
        let () = player_gotcha_msgs 0 in
        correcting_state state false
      else
        let () = player_gotcha_msgs 2 in
        state
  | 'v' ->
      if random_int == 1 || random_int == 2 then
        let () = player_gotcha_msgs 1 in
        correcting_state state true
      else
        let () = player_gotcha_msgs 2 in
        state
  | 'b' ->
      if random_int == 2 || random_int == 0 then
        let () = player_gotcha_msgs 2 in
        state
      else
        let () = player_gotcha_msgs 0 in
        correcting_state state true

let rec blind_box state : State.t =
  let () = draw_boxes () in
  let event = wait_next_event [ Key_pressed ] in
  if event.key == 'c' then winning_box 'c' state
  else if event.key == 'v' then winning_box 'v' state
  else if event.key == 'b' then winning_box 'b' state
  else blind_box state

(*[acceptance_state state] Draws the screen when the player has won the
  round and considers the blind box gifts *)
let rec acceptance_state state : State.t =
  Graphics.clear_graph ();
  Graphics.moveto 100 200;
  Graphics.set_color Graphics.black;
  Graphics.set_text_size 100;
  Graphics.draw_string "Congratulations on making it to the next level!";
  Graphics.moveto 100 100;
  Graphics.draw_string
    "A strange approaches with three gifts. Do you accept? y/n";
  let event = wait_next_event [ Key_pressed ] in
  if event.key == 'y' then blind_box state
  else if event.key == 'n' then state
  else acceptance_state state

let draw_game state =
  user_board Graphics.white state;
  enemy_board Graphics.white state;
  draw_user_caml (camel_type state.player.element_t);
  draw_enemy (camel_type state.ai.element_t)

let updated_won_state state =
  state |> update_won_state |> acceptance_state

let bgin_state state = { state with ai = { state.ai with hp = 0 } }

(*[render_game]colors caml and renders on page*)
let rec render_game (state : State.t) : State.t =
  Graphics.clear_graph ();
  let () = match_environment state.stage in
  let player_hp, ai_hp =
    (current_hp state.player, current_hp state.ai)
  in
  if player_hp <= 0 then
    let () = player_lost () in
    let event = wait_next_event [ Key_pressed ] in
    if event.key == 's' then render_game (update_lost_state state)
    else if event.key == 'q' then bgin_state state
    else render_game state
  else if ai_hp <= 0 then
    let () = player_won () in
    let event = wait_next_event [ Key_pressed ] in
    if event.key == 's' then render_game (updated_won_state state)
    else if event.key == 'q' then bgin_state state
    else render_game state
  else
    let () = draw_game state in
    let new_state = moves_state state in
    render_game new_state
