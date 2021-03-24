open Initstate

let _ =
  print_string
    "Hello! Welcome to CamlBattles. Please select your element" in 
  let element = read_line () in 
let camel = {
  hp = 10;
  level = 1;
  element_t = element;
  moves = [ "attack"; "defense"; "heal" ];
}



