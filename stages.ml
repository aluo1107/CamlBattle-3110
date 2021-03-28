open Camltypes
open Attack

(* Which terrain it is*)
type biome = string

type element = element_t

exception UnknownBiome of biome

type t = { biome_name : biome }

let stage_effect t =
  match t.biome_name with
  | "volcano" -> "fire"
  | "ocean" -> "water"
  | "jungle" -> "earth"
  | "cloud kingdom" -> "air"
  | x -> raise (UnknownBiome x)

let attack_stage_multi caml stage =
  attack_multi (caml_type caml) (stage_effect stage)

let stage_biome t = t.biome_name

let stage_boost t = stage_effect t
