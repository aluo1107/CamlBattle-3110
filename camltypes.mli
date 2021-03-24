(** The camel types in CamlBattle*)

(** The type of value representing move type*)
type move_t = string

(** The type of value representing the element type*)
type element_t = string

(** The type of the health points*)
type hp = int

(** The type of move identifiers that a player has *)
type moves = move_t list

(** The abstract type of values representing the effectiveness of the
    power of one element against another *)
type effect = int

(** The abstract type of values representing the combination of
    elemental forms of both the player and enemies*)
type element_match

(** The abstract type of values representing camels and enemies*)
type t

(** Raised when an unknown element type is encountered *)
exception UnknownElement of element_t

(** [attack_multi x] returns how effective the combination of the
    attacks are in the form of (element_t * element_t) where the first
    element is attacking. Requires x is a valid tuple containing two
    valid element_t types.*)
val attack_multi : element_match -> effect

(** [current_hp t] returns the current hp of the character in battle *)
val current_hp : t -> hp

(** [caml_type caml] returns the elemental type of the caml *)
val caml_type : t -> element_t

(** [battle_types t t] returns the elemental type of both the caml
    player and the enemy in a tuple *)
val effect_match : t -> t -> element_t * element_t

(** *)
val updated_status : t -> 
