extends Area2D

@export var speed = 300;

func _physics_process(delta):
	global_position.x += speed * delta;


func _on_visible_notifier_exited():
	queue_free();


func _on_area_entered(enemy):
	queue_free()
	enemy.die()
