open Attack
open Camltypes
open State

(*[health_check state] is the function for the ai to choose what move to
  do next. Based on the health of the ai, there are different
  probabilities for the different moves. If the AI’s health is less than
  or equal to 40% of their total health (which is their level * 10 +
  10), they have a 25% chance of attacking the player, a 37.5% chance of
  healing and 37.5% chance of defense. If their health is above 40%, it
  has a 75% chance of attacking, a 12.5% chance of healing, and a 12.5%
  chance of defense. The Random.float bound was used to determine which
  move is done. Floats from 0-10 are partitioned to reflect the
  percentages (e.g, to attack the player when the AI has less than 40%
  health, Random.float 10 would need to return a number less than 2.5).
  Requires [state] be a valid State.t*)

let health_check x state =
  print_float x;
  match
    float_of_int state.ai.hp /. float_of_int ((state.ai.level * 10) + 10)
    > 0.4
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
