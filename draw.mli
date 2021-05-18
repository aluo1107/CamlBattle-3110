(** This file details all of the functions that will be used to draw the
    graphics of the game *)

(** [color_background] color] takes in an rgb color and colors the
    background based on that color*)
val color_background : Graphics.color -> unit

(** [volcano_ashes unit] draws the volcano ashes when the player chooses
    the volcano biome*)
val volcano_ashes : unit -> unit

(** [volcano_background unit] draws the overall volcano background when
    the player chooses the volcano background*)
val volcano_background : unit -> unit

(** [ocean_background unit] draws the overall ocean background*)
val ocean_background : unit -> unit

(** [jungle_background unit] draws the overall jungle background*)
val jungle_background : unit -> unit

(** [cloud_kingdom_background unit] draws the overall cloud kingdom
    background*)
val cloud_kingdom_background : unit -> unit

(** [match_environment stage] takes in the user's chosen stage and draws
    the background based on that choice. *)
val match_environment : string -> unit

(** [caml_type caml] takes in the caml's element and returns the color
    it should be*)
val camel_type : string -> Graphics.color

(** [draw_user_caml color] draws the user caml based on the element
    chosen*)
val draw_user_caml : Graphics.color -> unit

(** [draw_enemy color] draws the enemy of the user caml on the screen.
    It draws the enemy based on the opposite element of the user's
    chosen element*)
val draw_enemy : Graphics.color -> unit

(** [user_board color] draws the player board that will keep track of
    the player stats including the hp, exp, and level*)
val user_board : Graphics.color -> State.t -> unit

(** [enemy_board color] draws the enemy board that will keep track of
    the enemy stats including the enemy's hp, exp, and level*)
val enemy_board : Graphics.color -> State.t -> unit

(** [drawing_menu state] draws the menu which reminds the user the moves
    and keyboard presses that correspond to each move*)
val drawing_menu : State.t -> unit

(** [render_welcome state] draws the welcome sign on the window *)
val render_welcome : unit -> unit

(** [moves_state state] will take in the user's chosen move which will
    then call moves in attack to take care of the effects of the
    player's move*)
val moves_state : State.t -> State.t

(** [render_choose_type state] asks and takes in the user's choice of
    element that will be used in the game*)
val render_choose_type : State.t -> State.t

(** [render_choose_biome state] asks and takes in the user's choice of
    biome that will be used in the game*)
val render_choose_biome : State.t -> string

(** [true_close state] gives the user an ending messages and prompts the
    user again to quit*)
val true_close : State.t -> unit

(** [render_game state] renders the game itself and takes care of the
    main loop of the game by calling all of the helper functions. The
    closing window is called when the ai or user's hp is zero or below*)
val render_game : State.t -> State.t

(** [update_lost_state state] returns the game state with the user's hp
    and ai reset to full. This function is only called after the user
    loses the game and chooses to restart the game*)
val update_lost_state : State.t -> State.t

(** [update_won_state state] returns the game state with the user and
    AI's hp increased by 10 with their levels also increased by 1*)
val update_won_state : State.t -> State.t

(** [render_closing state] renders the closing screen on the window. It
    gives the user the choice of clicking 'q' to quit the game or 's' to
    start the game again. If the user won, the ai and the user's levels
    and experience increase. *)
val render_inter : State.t -> State.t
