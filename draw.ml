open Camltypes
open Graphics
open State
open Attack
open Main_func
open Ai
open ANSITerminal

let white = rgb 255 255 255

let blue = rgb 30 25 255

(*creates the window that the graphics take place in*)
let open_window =
  open_graph " 640x480";
  set_window_title "CamlBattle"

(*sets the background color of the window*)
let clear_window color =
  let fg = foreground in
  set_color color;
  fill_rect 0 0 (size_x ()) (size_y ());
  set_color fg

(* create a gradient of colors from black at 0,0 to white at w-1,h-1 *)
let gradient arr w h =
  for y = 0 to h - 1 do
    for x = 0 to w - 1 do
      let s = 255 * (x + y) / (w + h - 2) in
      arr.(y).(x) <- rgb s s s
    done
  done

(* draws the gradient*)
let draw_gradient x y w h =
  let arr = Array.make_matrix h w white in
  gradient arr w h;
  draw_image (make_image arr) 0 0

(* let volcano_background = clear_window (rgb 255 0 0);
   Graphics.set_color (rgb 82 39 2); Graphics.moveto 400 140;
   Graphics.curveto (400, 140) (350, 124) (200, 0) *)

(*matches the color of the window with the stage*)
let match_environment stage =
  match stage with
  | "volcano" -> rgb 250 0 0
  | "ocean" -> rgb 0 206 209
  | "jungle" -> rgb 46 139 87
  | "cloud kingdom" -> rgb 255 255 0
  | _ -> failwith "Not valid"

(*matches the camel color with the camel element*)
let camel_type caml =
  match caml with
  | "water" -> rgb 115 255 246
  | "air" -> rgb 255 255 232
  | "fire" -> rgb 245 139 139
  | "earth" -> rgb 120 255 179
  | _ -> failwith "Not valid"

(*draws the camel onto the screen*)
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
  Graphics.moveto 283 124;
  Graphics.set_color (rgb 0 0 0);
  Graphics.draw_circle 283 124 5;
  Graphics.fill_circle 283 124 5;
  Graphics.set_color (rgb 250 75 75);
  Graphics.moveto 290 107;
  Graphics.draw_ellipse 290 107 7 2;
  Graphics.fill_ellipse 290 107 7 2;
  Graphics.set_color color;
  Graphics.set_line_width 5;
  (*Back legs*)
  Graphics.moveto 87 55;
  Graphics.lineto 74 10;
  Graphics.moveto 101 40;
  Graphics.lineto 92 10;
  (*Front legs*)
  Graphics.moveto 161 55;
  Graphics.lineto 170 10;
  Graphics.moveto 172 55;
  Graphics.lineto 190 10;
  Graphics.moveto 110 65;
  Graphics.draw_circle 70 60 10;
  Graphics.fill_circle 70 60 10

(* Graphics.moveto 170 120; Graphics.curveto (170, 90) (220, 30) (270,
   90) *)

(* Graphics.draw_circle 100 120 50; Graphics.fill_circle 100 120 50 *)

let draw_enemy_caml color =
  Graphics.set_color color;
  Graphics.draw_circle 500 400 50;
  Graphics.fill_circle 500 400 50

(*draws the current stats of the player*)
let user_board color (state : State.t) =
  Graphics.set_color color;
  Graphics.draw_rect 250 170 60 90;
  Graphics.fill_rect 250 170 60 90;
  Graphics.moveto 260 210;
  Graphics.set_color Graphics.black;
  Graphics.draw_string ("Exp: " ^ string_of_int state.player.exp);
  Graphics.moveto 260 235;
  Graphics.set_color Graphics.black;
  Graphics.draw_string ("Lv: " ^ string_of_int state.player.level);
  Graphics.moveto 260 250;
  Graphics.set_color Graphics.black;
  Graphics.draw_string
    ("HP: " ^ string_of_int (Camltypes.current_hp state.player))

let enemy_board color (state : State.t) =
  Graphics.set_color color;
  Graphics.draw_rect 350 400 60 90;
  Graphics.fill_rect 350 400 60 90;
  Graphics.moveto 350 460;
  Graphics.set_color Graphics.black;
  Graphics.draw_string ("Exp: " ^ string_of_int state.ai.exp);
  Graphics.moveto 350 430;
  Graphics.set_color Graphics.black;
  Graphics.draw_string ("Lv: " ^ string_of_int state.ai.level);
  Graphics.moveto 350 400;
  Graphics.set_color Graphics.black;
  Graphics.draw_string
    ("HP: " ^ string_of_int (Camltypes.current_hp state.ai))

let move_update state =
  ANSITerminal.print_string [ on_default ] " Your current hp is: ";
  print_endline (string_of_int (Camltypes.current_hp state.player));
  ANSITerminal.print_string [ on_default ] " The opponent's hp is: ";
  print_endline (string_of_int state.ai.hp);
  ANSITerminal.print_string [ on_default ] " AI Defense: ";
  print_endline (string_of_int state.ai.defense)

let drawing_menu state =
  Graphics.set_color Graphics.white;
  Graphics.draw_rect 250 300 150 80;
  Graphics.fill_rect 250 300 150 80;
  Graphics.moveto 270 360;
  Graphics.set_color Graphics.black;
  Graphics.draw_string "Press a to attack";
  Graphics.moveto 270 330;
  Graphics.set_color Graphics.black;
  Graphics.draw_string "Press s for heal";
  Graphics.moveto 270 300;
  Graphics.set_color Graphics.black;
  Graphics.draw_string "Press d for defend"

(*keeps track of the moves and player health*)
let moves_state state =
  drawing_menu state;
  let check_player_hp = Camltypes.current_hp state.player in
  let check_ai_hp = Camltypes.current_hp state.ai in
  if check_player_hp <= 0 || check_ai_hp <= 0 then
    let () = Graphics.close_graph () in
    Main_func.end_game state
  else move_update state;
  let event = wait_next_event [ Key_pressed ] in
  match event.key with
  | 's' ->
      Attack.move state state.player state.ai Heal true
      |> Ai.health_check
  | 'a' ->
      Attack.move state state.player state.ai Attack true
      |> Ai.health_check
  | 'd' ->
      Attack.move state state.player state.ai Defense true
      |> Ai.health_check
  | _ -> failwith "not right key"

(* let render_name = Graphics.set_color Graphics.black;
   Graphics.draw_string "Please enter your name."; input_name () *)

let rec render_welcome (state : State.t) =
  Graphics.clear_graph ();
  Graphics.moveto 200 200;
  Graphics.set_color Graphics.black;
  Graphics.set_text_size 100;
  Graphics.draw_string "Welcome to CamlBattles! Press s to start";
  let event = wait_next_event [ Key_pressed ] in
  if event.key == 's' then () else render_welcome state

let rec render_closing (state : State.t) =
  Graphics.clear_graph ();
  Graphics.moveto 200 200;
  Graphics.set_color Graphics.black;
  Graphics.set_text_size 100;
  let check_player_hp = Camltypes.current_hp state.player in
  let check_ai_hp = Camltypes.current_hp state.ai in
  if check_player_hp <= 0 then
    Graphics.draw_string "Game Over. Press s to play again."
  else if check_ai_hp <= 0 then
    Graphics.draw_string "You won! Press s to to play again."

(*colors caml and renders on page*)

let rec render_game (state : State.t) : unit =
  Graphics.clear_graph ();
  Graphics.set_color Graphics.black;
  clear_window (match_environment state.stage);
  user_board white state;
  enemy_board white state;
  draw_user_caml (camel_type state.player.element_t);
  draw_enemy_caml (camel_type state.ai.element_t);
  let new_state = moves_state state in
  render_game new_state

(* Graphics.set_text_size 30; Graphics.draw_string "Welcome to
   CamlBattles! Please select from fire, water, air, or \ earth.";
   input_name () *)
let render_background (state : State.t) =
  let () = open_window in
  let () = render_welcome state in
  render_game state

(* let r, g, b = color_to_rgb background in Printf.printf "Background
   color: %d %d %d\n" r g b *)
