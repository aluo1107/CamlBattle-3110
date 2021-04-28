open Camltypes
open Js_of_ocaml
open Sprite
open Dom_html

let document = Dom_html.document

let jstr = Js.string

let get_context canvas = canvas##getContext Dom_html._2d_

let render_box caml (posx,posy) = 
  let context  = caml.context in 
let (bbox, bboy) = caml.params.bbox_offset in 
let(bbsx, bbsy) = caml.params.bbox_size in 
context##strokeStyle <- Js.string "#FF0000";
context##strokeRect(posx+.bbox,posy+.bboy,bbsx, bbsy)

let render caml (posx,posy) =
  let context = caml.context in 
  let (sx, sy) = caml.params.src_offset in
  let (sw, sh) = caml.params.frame_size in
  let (dx, dy) = (posx,posy) in
  let (dw, dh) = caml.params.frame_size in
  let sx = sx +. (float_of_int !(caml.frame)) *. sw in
  context##drawImage_full(caml.img, sx, sy, sw, sh, dx, dy, dw, dh)

let hud canvas exp hp levels =
  let exp_string = string_of_int exp in
  let hp_string = string_of_int hp in
  let levels_string = string_of_int levels in 
  let context = canvas##getContext (Dom_html._2d_) in
  ignore context##font <- (Js.string ("10px 'Press Start 2P'"));
  ignore context##fillText (Js.string ("exp: "^exp_string), (float_of_int canvas##width) -. 140., 18.);
  ignore context##fillText (Js.string ("hp: "^hp_string), 120., 18.)
  ignore context##fillText (Js.string ("levels: "^levels_string), 120., 18.)

  let game_win ctx =
  ctx##rect (0.,0.,512.,512.);
  ctx##fillStyle <- (Js.string "black");
  ctx##fill ();
  ctx##fillStyle <- (Js.string "white");
  ctx##font <- (Js.string "20px 'Press Start 2P'");
  ctx##fillText (Js.string ("You win!"), 180., 128.);
  failwith "Game over."

(*game_loss displays a black screen stating a loss to finish that level play.*)
let game_loss ctx =
  ctx##rect (0.,0.,512.,512.);
  ctx##fillStyle <- (Js.string "black");
  ctx##fill ();
  ctx##fillStyle <- (Js.string "white");
  ctx##font <- (Js.string "20px 'Press Start 2P'");
  ctx##fillText (Js.string ("GAME OVER. You lose!"), 60., 128.);
  failwith "Game over."