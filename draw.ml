open Camltypes
open Graphics

let () = Graphics.open_graph " 400x500"

(*Camel size in the environment*)

let caml_size = 20

(*Camel color in the environment*)

let caml_color = Graphics.black

let x = Graphics.draw_circle 50 50 20

let white = rgb 255 255 255

let blue = rgb 30 25 255

(* no function for converting color back to rgb in Graphics *)
let color_to_rgb color =
  let r = (color land 0xFF0000) asr 0x10
  and g = (color land 0x00FF00) asr 0x8
  and b = color land 0x0000FF in
  (r, g, b)

let open_window =
  open_graph " 640x480";
  set_window_title "CamlBattle"

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

let draw_gradient x y w h =
  let arr = Array.make_matrix h w white in
  gradient arr w h;
  draw_image (make_image arr) 0 0

let match_environment stage =
  match stage with
  | "volcano" -> rgb 255 0 0
  | "ocean" -> rgb 0 206 209
  | "jungle" -> rgb 46 139 87
  | "cloud kingdom" -> rgb 255 255 0
  | _ -> failwith "Not valid"

let camel_type caml =
  match caml with
  | "water" -> rgb 115 255 246
  | "air" -> rgb 255 255 232
  | "fire" -> rgb 245 139 139
  | "earth" -> rgb 120 255 179
  | _ -> failwith "Not valid"

(* let draw_background = *)

(* let input_name () = while key_pressed () do let name = read_key () in
   () done *)

(* let render_name = Graphics.set_color Graphics.black;
   Graphics.draw_string "Please enter your name."; input_name () *)

let f x = x + 1

(* let rec event_loop = for i = 0 to 200 do plot i (f i) done *)

let render_welcome () =
  Graphics.clear_graph ();
  Graphics.set_color Graphics.black;
  Graphics.lineto 100 100

(* Graphics.moveto 100 100; Graphics.fill_rect 100 100 20 20 *)

(* Graphics.set_text_size 30; Graphics.draw_string "Welcome to
   CamlBattles! Please select from fire, water, air, or \ earth.";
   input_name () *)
let render_background state =
  open_window;
  (* clear_window match_environment state *)
  render_welcome ()

(* let r, g, b = color_to_rgb background in Printf.printf "Background
   color: %d %d %d\n" r g b *)

(* let render_stats caml = *)

(* let document = Dom_html.document

   let jstr = Js.string

   let get_context canvas = canvas##getContext Dom_html._2d_

   let render_box caml (posx,posy) = let context = caml.context in let
   (bbox, bboy) = caml.params.bbox_offset in let(bbsx, bbsy) =
   caml.params.bbox_size in context##strokeStyle <- Js.string "#FF0000";
   context##strokeRect(posx+.bbox,posy+.bboy,bbsx, bbsy)

   let render caml (posx,posy) = let context = caml.context in let (sx,
   sy) = caml.params.src_offset in let (sw, sh) = caml.params.frame_size
   in let (dx, dy) = (posx,posy) in let (dw, dh) =
   caml.params.frame_size in let sx = sx +. (float_of_int !(caml.frame))
   *. sw in context##drawImage_full(caml.img, sx, sy, sw, sh, dx, dy,
   dw, dh)

   let hud canvas exp hp levels = let exp_string = string_of_int exp in
   let hp_string = string_of_int hp in let levels_string = string_of_int
   levels in let context = canvas##getContext (Dom_html._2d_) in ignore
   context##font <- (Js.string ("10px 'Press Start 2P'")); ignore
   context##fillText (Js.string ("exp: "^exp_string), (float_of_int
   canvas##width) -. 140., 18.); ignore context##fillText (Js.string
   ("hp: "^hp_string), 120., 18.) ignore context##fillText (Js.string
   ("levels: "^levels_string), 120., 18.)

   let game_win ctx = ctx##rect (0.,0.,512.,512.); ctx##fillStyle <-
   (Js.string "black"); ctx##fill (); ctx##fillStyle <- (Js.string
   "white"); ctx##font <- (Js.string "20px 'Press Start 2P'");
   ctx##fillText (Js.string ("You win!"), 180., 128.); failwith "Game
   over."

   (*game_loss displays a black screen stating a loss to finish that
   level play.*) let game_loss ctx = ctx##rect (0.,0.,512.,512.);
   ctx##fillStyle <- (Js.string "black"); ctx##fill (); ctx##fillStyle
   <- (Js.string "white"); ctx##font <- (Js.string "20px 'Press Start
   2P'"); ctx##fillText (Js.string ("GAME OVER. You lose!"), 60., 128.);
   failwith "Game over." *)
