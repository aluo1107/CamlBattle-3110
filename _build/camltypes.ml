type move_t =
  | Attack
  | Defense
  | Heal

type element_t = string

type hp = int

type moves = move_t list

(* Effect will be represented by an int where 0 represents weak, 1
   represents a normal attack and 2 represents super effective *)

type effect =
  | Weak
  | Normal
  | SuperEffect

type t = {
  hp : int;
  level : int;
  element_t : element_t;
  moves : move_t list;
  exp : int;
}

exception UnknownElement of element_t

let exp_update caml =
  if caml.exp > 100 || caml.exp = 100 then
    {
      hp = caml.hp + 10;
      level = caml.level + 1;
      element_t = caml.element_t;
      moves = caml.moves;
      exp = 0;
    }
  else caml

let effect_multi = function
  | Weak -> 0.5
  | Normal -> 1.0
  | SuperEffect -> 1.5

let attack_multi (caml : element_t) (enemy : element_t) =
  match (caml, enemy) with
  | "air", "air" -> Normal
  | "air", "earth" -> SuperEffect
  | "air", "water" -> Normal
  | "air", "fire" -> Weak
  | "earth", "air" -> SuperEffect
  | "earth", "earth" -> Normal
  | "earth", "water" -> SuperEffect
  | "earth", "fire" -> Normal
  | "water", "air" -> Normal
  | "water", "earth" -> Weak
  | "water", "water" -> Normal
  | "water", "fire" -> SuperEffect
  | "fire", "air" -> Normal
  | "fire", "earth" -> Normal
  | "fire", "water" -> Weak
  | "fire", "fire" -> Normal
  | x, y -> raise (UnknownElement x)

let caml_type t = t.element_t

let effect_match t t = (t.element_t, t.element_t)

let current_hp t = t.hp
