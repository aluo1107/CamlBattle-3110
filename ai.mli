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

val health_check : float -> State.t -> State.t
