# TODO class_name PlayerState[This State]
extends PlayerState


# What happens when this state is initiialzed?
func init() -> void:
	pass

# What happens when we enter this state?
func enter() -> void:
	animation_player.play("walk")
	pass


# What happens when we exit this state?
func exit() -> void:
	pass


# What happens when an input is pressed
func handle_input(_event: InputEvent) -> PlayerState:
	# ToDo handle input
	return next_state


# What happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	if player.velocity.x == 0:
		return idle
	return next_state


# What happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.walk_speed
	return next_state
