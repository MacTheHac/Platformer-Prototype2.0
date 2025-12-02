# TODO class_name PlayerState[This State]
extends EnemyState


# What happens when this state is initiialzed?
func init() -> void:
	pass

# What happens when we enter this state?
func enter() -> void:
	# ToDo animation_player.play("[animation_name")
	pass


# What happens when we exit this state?
func exit() -> void:
	pass


# What happens when an input is pressed
func handle_input(_event: InputEvent) -> EnemyState:
	# ToDo handle input
	return next_state


# What happens each process tick in this state?
func process(_delta: float) -> EnemyState:
	return next_state


# What happens each physics_process tick in this state?
func physics_process(_delta: float) -> EnemyState:
	return next_state
