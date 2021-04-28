open Actors
open Js_of_ocaml

type xy = float * float

type caml_params = {
  img_src : string;
  frame_size : xy;
  src_offset : xy;
  bbox_offset : xy;
  bbox_size : xy;
}

type caml = {
  mutable params : caml_params;
  context : Dom_html.canvasRenderingContext2D Js.t;
  mutable img : Dom_html.imageElement Js.t;
}

let setup_caml ?bb_off:(bbox_offset=(0.,0.)) ?bb_sz:(bbox_size=(0.,0.)) img_src 
frame_size src_offset= 
let bbox_size = if bbox_size = (0.,0.) then frame_size else bbox_size in 
let img_src = "./backgrounds/" ^ img_src in 
{
  img_src; 
  frame_size; 
  src_offset; 
  bbox_offset; 
  bbox_size;
}

let make_from_params params context = 
  let img  = (Dom_html.createImg Dom_html.document) in 
  img##src <- (Js.string params.img_src) ;
  {
    params; 
    context;
    img;
  }
 let make_bgd context = 
  let params = setup_caml "cloud_kingdom.png" 1 0 (1000., 625.) (0.,0.) in make_from_params 
  params context
