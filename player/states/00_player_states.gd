@icon("res://player/states/state.svg")
class_name PlayerState 
extends Node


#region /// export vars
#endregion

#region /// remaining vars
var player: Player
var next_state: PlayerState = null
#endregion

#region /// other node references
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var sprite: Sprite2D = %Sprite2D
#endregion

#region /// state references
# referenz to all other states
@onready var idle: PlayerState = %Idle
@onready var walk: Node = %Walk
@onready var jump: PlayerState = %Jump
@onready var fall: PlayerState = %Fall
#endregion

# What happens when this state is initiialzed?
func init() -> void:
	pass

# What happens when we enter this state?
func enter() -> void:
	pass


# What happens when we exit this state?
func exit() -> void:
	pass


# What happens when an input is pressed
func handle_input(_event: InputEvent) -> PlayerState:
	return next_state


# What happens each process tick in this state?
func process(_delta: float) -> PlayerState:
	return next_state


# What happens each physics_process tick in this state?
func physics_process(_delta: float) -> PlayerState:
	return next_state
