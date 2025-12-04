extends Node

signal health_updated
signal score_updated
signal player_died


################################################################################
# Getter and setter for health
var health: int = 0:
	get:
		return health
	set(value):
		health = value
		emit_signal("health_updated")
		if health <=0:
			emit_signal("player_died")
@export var max_health: int = 3


################################################################################
# Getter and setter for score
var score: int = 0:
	get:
		return score
	set(value):
		score = value
		emit_signal("score_updated")


################################################################################
func _ready() -> void:
		health = max_health
