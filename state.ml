open Camltypes
type t = {
  player : Camltypes.t;
  ai : Camltypes.t;
  stage : Camltypes.stage;
  turn : bool;
}

(* if [player_turn] returns true, then it indicates the player's turn.
   If it returns false, it's the enemy's turn.*)

(* let player_turn bool = if true then match player_command with | 65 ->
   command.a <- true | 104 -> command.d <- true | 83 -> command.s <-
   true *)
