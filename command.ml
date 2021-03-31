open Camltypes

type command = {
  mutable a : bool;
  mutable d : bool;
  mutable s : bool;
}

let player_command = { a = false; d = false; s = false }
