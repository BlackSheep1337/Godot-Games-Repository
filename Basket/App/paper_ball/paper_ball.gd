class_name PaperBall
extends RigidBody2D

@onready var point_label = preload("res://App/points_label/points_label.tscn")
var point_label_inst
const super_ball_multiplier_by_time = { 90: 8, 70: 5, 50: 3, 30: 2, 10: 1 }
@export var _damage: int = 20
@export var _point: int = 5
@export var _super_ball_gravity_scale: float = 1.0
@export var _super_ball_point: int = 10
@export var _super_ball_number: int = 0
static var _super_ball_multiplier: int = 13
 
func _ready():
	SignalManager.on_timer_tick.connect(on_timer_tick)
	point_label_inst = point_label.instantiate()


func _on_visible_on_screen_notifier_2d_screen_exited():
	SignalManager.on_damage_taken.emit(_damage)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered():
	var get_random_num = randi_range(_super_ball_number, _super_ball_multiplier)
	if get_random_num == _super_ball_number:
		gravity_scale = _super_ball_gravity_scale
		_point = _super_ball_point

func on_timer_tick(time: int) -> void:
	if super_ball_multiplier_by_time.has(time):
		_super_ball_multiplier = super_ball_multiplier_by_time[time]

func _on_body_entered(body: CharacterBody2D):
	if body is Player:
		SignalManager.on_get_hit.emit(_point)
		queue_free()
