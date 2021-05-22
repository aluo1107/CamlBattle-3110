(** This file details all of the functions that will be used to draw the
    graphics of the game *)

(** [color_background color] takes in an rgb color and colors the
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
val render_choose_type : unit -> string

(** [render_choose_biome state] asks and takes in the user's choice of
    biome that will be used in the game*)
val render_choose_biome : unit -> string

(** [true_close state] gives the user an ending messages and prompts the
    user again to quit*)
val true_close : State.t -> unit

(** [render_game] this function first matches to the environment of the
    state and draws the background based on that biome. Next, it checks
    whether the player or the AI's hp is less than or equal to zero. If
    the player's HP is less than or equal to zero, the player is asked
    whether they would like to quit or restart the game. If the AI's HP
    is less than or equal to zero, then the player is prompted to either
    choose to quit or they can choose to advance in levels. If neither
    conditions are true, the function calls helper functions to draw the
    game and calls the moves_state function to take care of the player's
    moves and effects on the AI.*)
val render_game : State.t -> State.t

(** [update_lost_state state] returns the game state with the user's hp
    and ai reset to full. This function is only called after the user
    loses the game and chooses to restart the game*)
val update_lost_state : State.t -> State.t

(** [update_won_state state] returns the game state with the user and
    AI's hp increased by 10 with their levels also increased by 1*)
val update_won_state : State.t -> State.t

(** [correcting_state state good_result] returns a new state with either
    the player's HP increased or decreased by their level*)
val correcting_state : State.t -> bool -> State.t

(** [winning_box chosen_box state] returns the new state with the result
    of the player either choosing the left box, middle box, or right
    box. At the beginning of the function, a random int is generate
    between 0 and 3. For the first box, the player has a 2/3rds chance
    of getting a boost and 1/3rd chance of recieving nothing. This is
    true for the middle box as well where instead the player has 2/3rds
    chance of getting a hit to their HP. In the last box, the player has
    a 2/3rd chance of recieving nothing and a 1/3rd chance of recieving
    a boost to their HP*)
val winning_box : Camltypes.blind_boxes -> State.t -> State.t

(** [blind_box state] is the main function for the blind box minigame
    and calls the other functions within itself.*)
val blind_box : State.t -> State.t
