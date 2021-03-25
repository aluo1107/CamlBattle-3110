open Initstate
open Camltypes

let _ =
  print_string
    "Hello! Welcome to CamlBattles. Please select your element: fire, \
     water, air, or earth"

let element = read_line ()

let camel =
  {
    hp = 10;
    level = 1;
    element_t = element;
    moves = [ Attack; Defense; Heal ];
    exp = 0;
  }
