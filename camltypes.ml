type move_t =
  | Attack
  | Defense
  | Heal

type element_t = string

type hp = int

type moves = move_t list

type blind_boxes =
  | LeftBox
  | MiddleBox
  | RightBox

type endings =
  | GoodEnd
  | BadEnd
  | NeutralEnd

(* Effect will be represented by an int where 0 represents weak, 1
   represents a normal attack and 2 represents super effective *)

type effect =
  | Weak
  | Normal
  | SuperEffect

(* The type for both camls and enemies *)
type t = {
  hp : int;
  level : int;
  element_t : element_t;
  moves : move_t list;
  exp : int;
  defense : int;
  current_move : int;
}

type stage = string

exception UnknownStage of stage

exception UnknownElement of element_t

(*[exp_update caml] updates the camel level based on exp*)
let exp_update caml =
  {
    caml with
    hp = (caml.level + 1) * 10;
    level = caml.level + 1;
    exp = 0;
  }

(*[effect_multi effect] matches effect and returns the multiplier*)
let effect_multi = function
  | Weak -> 1.0
  | Normal -> 1.5
  | SuperEffect -> 2.0

(*returns the type effect on the camel*)
let attack_multi (caml : element_t) (enemy : element_t) =
  match (caml, enemy) with
  | "air", "air" -> Normal
  | "air", "earth" -> SuperEffect
  | "air", "water" -> Normal
  | "air", "fire" -> Weak
  | "earth", "air" -> Weak
  | "earth", "earth" -> Normal
  | "earth", "water" -> SuperEffect
  | "earth", "fire" -> Normal
  | "water", "air" -> Normal
  | "water", "earth" -> Weak
  | "water", "water" -> Normal
  | "water", "fire" -> SuperEffect
  | "fire", "air" -> SuperEffect
  | "fire", "earth" -> Normal
  | "fire", "water" -> Weak
  | "fire", "fire" -> Normal
  | x, y -> raise (UnknownElement x)

(*returns the camltype *)
let caml_type t = t.element_t

(* returns a tuple of a player and AI matchup*)
let effect_match (t : t) t = (t.element_t, t.element_t)

(* returns the current hp of a type t*)
let current_hp t = t.hp

(* updates hp with given int*)
let updated_hp t int = { t with hp = t.hp - int; defense = 0 }

(* updates defense with given int*)
let updated_defense t int = { t with defense = int }

(* returns current defense*)
let current_defense t = t.defense

(* Stage*)
(* matches the stage to the element*)
let stage_effect t =
  match t with
  | "volcano" -> "fire"
  | "ocean" -> "water"
  | "jungle" -> "earth"
  | "cloud kingdom" -> "air"
  | x -> raise (UnknownStage x)

(*Returns the effect of element match ups*)
let attack_stage_multi caml stage =
  let biome_effec = stage_effect stage in
  match (caml, biome_effec) with
  | "air", "air" -> SuperEffect
  | "air", "earth" -> Normal
  | "air", "water" -> Normal
  | "air", "fire" -> Weak
  | "earth", "air" -> Weak
  | "earth", "earth" -> SuperEffect
  | "earth", "water" -> Normal
  | "earth", "fire" -> Normal
  | "water", "air" -> Normal
  | "water", "earth" -> Weak
  | "water", "water" -> SuperEffect
  | "water", "fire" -> Normal
  | "fire", "air" -> Normal
  | "fire", "earth" -> Normal
  | "fire", "water" -> Weak
  | "fire", "fire" -> SuperEffect
  | x, y -> raise (UnknownElement x)
