(** The camel types in CamlBattle*)

(** The abstract value representing move type*)
type move_t =  | Attack
  | Defense
  | Heal

(** The type of value representing the element type*)
type element_t = string

(** The type of the health points*)
type hp = int

(** The type of move identifiers that a player has *)
type moves = move_t list

(** The abstract type of values representing the effectiveness of the
    power of one element against another *)
type effect

(** The abstract type of values representing camels and enemies*)
type t = {
  hp : int;
      level : int; element_t : element_t; moves : move_t list; exp :
        int; 
}

(** Raised when an unknown element type is encountered *)
exception UnknownElement of element_t

(** [exp_update t] checks to see if experience is at or above 100 after
    battle. If it is, will return new caml object with level increased
    by 1. *)
val exp_update : t -> t

(** [effect_multi effect] returns the multiplier of the result of the
    match up between enemy and player caml *)
val effect_multi : effect -> float

(** [attack_multi x] returns how effective the combination of the
    attacks are in the form of (element_t * element_t) where the first
    element is attacking. Requires x is a valid tuple containing two
    valid element_t types.*)
val attack_multi : element_t -> element_t -> effect

(** [current_hp t] returns the current hp of the character in battle *)
val current_hp : t -> hp

(** [caml_type caml] returns the elemental type of the caml *)
val caml_type : t -> element_t

(** [battle_types t t] returns the elemental type of both the caml
    player and the enemy in a tuple *)
val effect_match : t -> t -> element_t * element_t
