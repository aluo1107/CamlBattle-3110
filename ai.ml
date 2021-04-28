open Attack
open Camltypes
open State

(* AI checks their health *)

let health_check state =
  let x = Random.float 10.0 in
  print_float x;
  match
    float_of_int state.ai.hp /. float_of_int (state.ai.level * 10) > 0.4
  with
  | true -> (
      match x < 7.5 with
      | true ->
          print_endline " ai attacking";
          Attack.move state state.ai state.player Attack state.turn
      | false -> (
          match x < 8.75 with
          | true ->
              print_endline " ai healing";
              Attack.move state state.ai state.player Heal state.turn
          | false ->
              print_endline " ai defense";
              Attack.move state state.ai state.player Defense state.turn
          ))
  | false -> (
      match x < 2.5 with
      | true ->
          print_endline " ai attacking";
          Attack.move state state.ai state.player Attack state.turn
      | false -> (
          match x < 6.25 with
          | true ->
              print_endline " ai healing";
              Attack.move state state.ai state.player Heal state.turn
          | false ->
              print_endline " ai defense";
              Attack.move state state.ai state.player Defense state.turn
          ))
