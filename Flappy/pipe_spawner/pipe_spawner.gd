extends Node

class_name PipeSpawner

var pipe_pair_scene = preload("res://pipe_spawner/pipes_pair.tscn")

@export var pipe_speed = -150
@onready var spawn_timer = $SpawnTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_timer.timeout.connect(spawn_pipes)
	spawn_timer.start()
	
func start_spawning_pipes() -> void:
	pass

func spawn_pipes() -> void:
	var pipes = pipe_pair_scene.instantiate() as PipePair
	add_child(pipes)
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	pipes.position.x = viewport_rect.end.x
	
	var half_height = viewport_rect.size.y / 2
	var fifteen_percent_of_screen = viewport_rect.size.y * 0.15
	var sixtyfive_porcent_of_screen = viewport_rect.size.y * 0.65
	pipes.position.y = randf_range(fifteen_percent_of_screen - half_height, sixtyfive_porcent_of_screen - half_height)
	pipes.set_speed(pipe_speed)
	
	SignalManager.bird_entred.connect(on_bird_entred)
	SignalManager.point_scored.connect(on_point_scored)

func on_bird_entred() -> void:
	SignalManager.bird_crashed.emit()
	stop()

func stop() -> void:
	spawn_timer.stop()
	for pipe in get_children().filter(func (child): return child is PipePair):
		(pipe as PipePair).speed = 0

func on_point_scored() -> void:
	SignalManager.point_scored.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
