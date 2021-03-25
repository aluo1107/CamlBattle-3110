open Initstate
open Camltypes

let _ =
  print_string
    "Hello! Welcome to CamlBattles. Please select your element"

let element = read_line ()

(* let (camel : Camltypes.t) = { hp = 10; level = 1; element_t =
   element; moves = [ "attack"; "defense"; "heal" ]; } *)
