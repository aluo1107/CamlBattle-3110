(** Stage types in Stages*)

(** The type of value representing biome*)
type biome = string

(** Raised when an unknown biome type is encountered *)
exception UnknownBiome of biome

(** The abstract type of values representing a stage.*)
type t = { biome_name : biome }

(** [stage effect t] returns the element type that gets boosted by the
    stage.*)
val stage_effect : t -> Camltypes.element_t

(** [attack_stage_multi caml stage] returns the attack multiplier of the
    caml according to what stage biome they are in. *)
val attack_stage_multi : Camltypes.t -> t -> Camltypes.effect

(** [stage_biome t] is a getter function for the biome name of the stage *)
val stage_biome : t -> biome

(** [stage_boost t] is a getter function for which element gets boosted
    according to which biome it is*)
val stage_boost : t -> Camltypes.element_t
