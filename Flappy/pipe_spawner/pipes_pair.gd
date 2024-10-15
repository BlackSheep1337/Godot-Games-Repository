extends Node2D

class_name PipePair

var speed = 0

func set_speed(new_speed):
	speed = new_speed
	
func _process(delta):
	position.x = speed * delta

func _on_top_pipe_body_entered(body):
	SignalManager.bird_entred.emit()

func _on_down_pipe_body_entered(body):
	SignalManager.bird_entred.emit()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
