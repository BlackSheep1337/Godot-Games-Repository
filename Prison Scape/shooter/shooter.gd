extends Node2D
@onready var shoot_timer = $ShootTimer

@export var speed: float = 50.0
@export var life_span: float = 10.0
@export var shoot_delay: float = 0.4

var _can_shoot: bool = true

func shoot() -> void:
	if !_can_shoot: return

	_can_shoot = false
	

func _on_shoot_timer_timeout():
	_can_shoot = true
