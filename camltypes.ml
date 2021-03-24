type move_t = string

type element_t = string

type moves = move_t list

(* Effect will be represented by an int where 0 represents weak, 1
   represents a normal attack and 2 represents super effective *)
type effect = int

type t = {
  hp : int;
  level : int;
  element_t : element_t;
  moves : move_t list;
}

exception UnknownElement of element_t

let attack_multi (caml : t) (enemy : t) =
  match (caml.element_t, enemy.element_t) with
  | "air", "air" -> 1
  | "air", "earth" -> 2
  | "air", "water" -> 1
  | "air", "fire" -> 0
  | "earth", "air" -> 0
  | "earth", "earth" -> 1
  | "earth", "water" -> 2
  | "earth", "fire" -> 1
  | "water", "air" -> 1
  | "water", "earth" -> 0
  | "water", "water" -> 1
  | "water", "fire" -> 2
  | "fire", "air" -> 1
  | "fire", "earth" -> 1
  | "fire", "water" -> 0
  | "fire", "fire" -> 1
  | x, y -> raise (UnknownElement x)

let caml_type t = t.element_t

let effect_match t t = (t.element_t, t.element_t)

let current_hp t = t.hp
