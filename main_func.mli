(** 
Contains all the helper functions necessary to run main
*)
(** [summary_stats camltypes.t] takes in a caml and returns the summary
    stats during the course of the game*)
val summary_stats : Camltypes.t -> unit

(** [end_game State.t] takes in the current state and ends the game*)
val end_game : State.t -> unit

(** welcome_game is the player's choice of move that they would like to
    use*)
val welcome_game : string -> string

(** [caml_init Camltypes.element_t] takes in the selected element and
    returns the newly created camltype*)
val caml_init : Camltypes.element_t -> Camltypes.t

(** [find_ai_element string] takes in the player's element and returns
    the element that weak against it*)
val find_ai_element : string -> string

(** [ai_caml t] takes in the player caml and returns a caml with the
    opposite element*)
val ai_caml : Camltypes.t -> Camltypes.t
