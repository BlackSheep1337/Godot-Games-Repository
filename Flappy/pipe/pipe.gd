extends Area2D
class_name Pipe

signal hit

func _on_body_entered(_body):
	print("Bird Hited")
	hit.emit()
