extends Node2D

@onready var paper_ball = preload("res://App/paper_ball/paper_ball.tscn")
var timer = Timer.new()

@export var start_time = 0.5
@export var end_time = 2.0

func _ready():
	add_child(timer)
	timer.connect('timeout', _on_timeout)
	set_timer_timeout()

# Function to set a random timeout for the timer
func set_timer_timeout() -> void:
	timer.wait_time = randf_range(start_time, end_time)
	timer.start()

func _on_timeout() -> void:
	var marker_node = get_children()[randf_range(0, get_children().size() - 1)]
	if marker_node is Marker2D:
		var paper_ball_inst = paper_ball.instantiate()
		paper_ball_inst.global_position = marker_node.global_position
		paper_ball_inst.modulate = GameManager.get_rand_rgb_color()
		add_child(paper_ball_inst)
		set_timer_timeout()	
