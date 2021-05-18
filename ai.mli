(** [health_check state] is the function for the ai to choose what move
    to do next.*)

val health_check : float -> State.t -> State.t
