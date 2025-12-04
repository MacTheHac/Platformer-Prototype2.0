# TODO class_name PlayerState[This State]
extends PlayerState

@export var jump_velocity: float = 450.0

################################################################################
################################################################################
# What happens when this state is initiialzed?
func init() -> void:
	pass

################################################################################
# What happens when we enter this state?
func enter() -> void:
	player.animation_player.play("jump")
	player.animation_player.pause()
	player.velocity.y = -jump_velocity


################################################################################
# What happens when we exit this state?
func exit() -> void:
	pass


################################################################################
# What happens when an input is pressed
func handle_input(_event: InputEvent) -> PlayerState:
	# ToDo handle input
	return next_state


################################################################################
# What happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	return next_state


################################################################################
# What happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	return next_state


################################################################################
func set_jump_frame() -> void:
	var frame: float = remap(player.velocity.y, -jump_velocity, 0.0, 0.0, 0.5)
	player.animation_player.seek(frame, true)
	pass
