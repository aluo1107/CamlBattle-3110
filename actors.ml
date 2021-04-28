type xy = {
  mutable x : float;
  mutable y : float;
}

type keyboard_ctl =
  | P_attack
  | P_heal
  | P_defense

type player_caml =
  | Fire_caml
  | Water_caml
  | Earth_caml
  | Air_caml

type caml_image =
  | Player_caml
  | Enemy_caml

type attack_graphic =
  | Fire_attack
  | Air_attack
  | Water_attack
  | Earth_attack
