class_name PlayerStateFall
extends PlayerState

@export var coyote_time: float = 0.125
@export var fall_gravity_multiplier: float = 1.165
@export var jump_buffer_time: float = 0.2
@export var max_fall_velocity: float = 600

var coyote_timer: float = 0
var buffer_timer: float = 0

# What happens when this state is initiialzed?
func init() -> void:
	pass

################################################################################
# What happens when we enter this state?
func enter() -> void:
	animation_player.play("jump")
	animation_player.pause()
	player.gravity_multiplier = fall_gravity_multiplier
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time


# What happens when we exit this state?
func exit() -> void:
	player.gravity_multiplier = 1.0


# What happens when an input is pressed
func handle_input(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		if coyote_timer > 0:
			return jump
		else: 
				buffer_timer = jump_buffer_time
	return next_state


# What happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	coyote_timer -= _delta
	buffer_timer -= _delta
	set_jump_frame()
	return next_state


# What happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	if player.is_on_floor():
		if buffer_timer > 0:
			return jump 
		return idle
	player.velocity.x = player.direction.x * player.move_speed
	return next_state


func set_jump_frame() -> void:
	var frame: float = remap(player.velocity.y, 0.0, max_fall_velocity, 0.5, 1.0)
	animation_player.seek(frame, true)
