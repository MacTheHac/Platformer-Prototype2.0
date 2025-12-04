class_name Player
extends CharacterBody2D

#region /// Signals
#endregion

#region /// export vars
@export var move_speed: float = 150.0
#endregion

#region /// State Machine Variables
var states: Array[PlayerState]
var current_state: PlayerState:
	get: return states.front()
var previous_state: PlayerState:
	get: return states[1]
#endregion

#region /// remaining vars 
var direction: Vector2 = Vector2.ZERO
var gravity: float = 980
var gravity_multiplier: float = 1.0
#endregion

#region /// onready vars
@onready var sprite: Sprite2D = %Sprite2D
@onready var label: Label = %StateLabel
#endregion

################################################################################
################################################################################
func _ready() -> void:
	init_states()


################################################################################
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.handle_input(event))


################################################################################
func _process(_delta: float) -> void:
	update_direction()
	change_state(current_state.process(_delta))


################################################################################
func _physics_process(delta: float) -> void:
	velocity.y += gravity * gravity_multiplier * delta
	#print("CurrentState: ", current_state.name, " could_climb: ", could_climb)
	#print("velocity: ",velocity)
	change_state(current_state.physics_process(delta))
	move_and_slide()


################################################################################
func init_states() -> void:
	states = []
	# die states einlesen
	for child in $States.get_children():
		if child is PlayerState:
			states.append(child)
			child.player = self
	
	# wir machen nur weiter, wenn wir tatsächlich States gefunden haben
	if states.size() == 0:
		return
	# states initialisieren
	for state in states:
		state.init()
	# den aktuellen state setzen
	change_state(current_state)
	current_state.enter()
	label.text = current_state.name


################################################################################
func change_state(new_state: PlayerState) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	
	states.push_front(new_state)
	current_state.enter()
	states.resize(3) # hold three states
	label.text = current_state.name


################################################################################
func update_direction() -> void:
	# set previous_direction before direction is changed
	var previous_direction: Vector2 = direction
	#print("previos_direction: ", previous_direction)
	# cleans up deadzone stickdrift issue: dedects single axis instead of get_vector()
	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("up", "down")
	direction = Vector2(x_axis, y_axis)
	 
	
	if previous_direction.x != direction.x: # directions.x has changed
		if direction.x < 0: # facing left
			sprite.flip_h = true   
		elif direction.x > 0: #facing right
			sprite.flip_h = false


################################################################################
func take_damage(damage: int) -> void:
	globals.health -= damage
	if globals.health > 0:
		get_tree().reload_current_scene()
