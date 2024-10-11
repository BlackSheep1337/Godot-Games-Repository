extends Node2D

signal enemy_spawned(enemy_instance)
signal path_enemy_spawned(path_enemy_instance)

var enemy_scene = preload("res://scenes/enemy.tscn");
var path_enemy = preload("res://scenes/path_enemy.tscn")

@onready var spawn_positions = $SpwnPositions

func _on_timeout():
	spawn_enemy()

func spawn_enemy():
	var positions = spawn_positions.get_children()
	var random_position = positions.pick_random()
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = random_position.global_position
	emit_signal("enemy_spawned", enemy_instance)
	#add_child(enemy_instance)


func _on_timer_2_timeout():
	spawn_path_enemy()

func spawn_path_enemy():
	var path_enemy_instance = path_enemy.instantiate()
	emit_signal("path_enemy_spawned", path_enemy_instance)
	
