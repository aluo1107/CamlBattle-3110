open Camltypes

(* Which element is boosted*)
type boosted = element_t

(* Which terrain it is*)
type biome = string

exception UnknownElement of element_t

type t = {
  biome : biome;
  boosted : element_t;
}

type effect =
  | Weak
  | Normal
  | SuperEffect

let effect_multiplier = function
  | Weak -> 0.5
  | Normal -> 1.0
  | SuperEffect -> 1.5

let attack_stage_multi caml (stage : t) =
  match (caml_type caml, stage.boosted) with
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

let stage_biome t = t.biome

let stage_boost t = t.boosted

let effect_match t t = (t.boosted, t.boosted)
