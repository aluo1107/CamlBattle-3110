open Camltypes


let caml_init =
  {
    hp = 10;
    level = 1;
    element_t = element;
    moves = [ Attack; Defense; Heal ];
    exp = 0;
  }


let summary_stats caml = 
  if caml.hp <= 0 || enemy.hp <= 0 then 
    print_string ("Your experience gained is" ^ caml.exp)
    print_string ("Your current level is" ^ caml.level)
  caml.hp = 0


(* [end_game] prints the end of game message and prompts player to play again. *)
let end_game = 
  print_string "Game Over. Please select play again to continue."


let user_output filename =
  let channel = open_in filename in
  let line = ref "" in
  try
    while true do
      line := input_line channel;
      print_endline !line
    done
  with End_of_file -> ()

let _ =
  for i = 1 to Array.length Sys.argv - 1 do
    user_output Sys.argv.(i)
  done

