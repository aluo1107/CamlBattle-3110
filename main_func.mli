(*[valid_input ()] checks to see if what the user has entered is a valid
  element. If it isn't, calls the function again val valid_input :
  string -> string *)

(*[choose_attack input] takes in the user's input as a string and then
  returns the attack that the user wants to use *)
val choose_attack : string -> Camltypes.move_t

(*[get_attack] gets the user attack by prompting the user to enter the
  move they would like to make. val get_attack : string -> string *)

(*[player_move] gets the user's move choice*)
val choose_move : string -> Camltypes.move_t

(*[summary_stats camltypes.t] takes in a caml and returns the summary
  stats during the course of the game*)
val summary_stats : Camltypes.t -> unit

(*[end_game State.t] takes in the current state and ends the game*)
val end_game : State.t -> unit

(* welcome_game is the player's choice of move that they would like to
   use*)
val welcome_game : string -> string

(*[caml_init Camltypes.element_t] takes in the selected element and
  returns the newly created camltype*)
val caml_init : Camltypes.element_t -> Camltypes.t

(*[find_ai_element string] takes in the player's element and returns the
  element that weak against it*)
val find_ai_element : string -> string

(*[ai_caml t] takes in the player caml and returns a caml with the
  opposite element*)
val ai_caml : Camltypes.t -> Camltypes.t

(*[pick_biome] prompts the user to pick the biome that they would like
  the game to take place in.*)
val pick_biome : string -> string

(*[play_game State.t] takes care of the actual game when the player is
  playing. It takes in the initial game state with the player's choices
  and updates the game based on the moves that the user chooses.*)
val play_game : State.t -> unit
