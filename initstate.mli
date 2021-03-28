(** The caml stats in CamlBattle*)


(*[caml] initializes the caml. *)
val caml_init 

(* [stats_upate] returns the summary stats (hp, level, exp) of the caml when
either the caml or enemy has health 0 (end of battle) and resets health to 0. *)
val summary_stats : t -> t













