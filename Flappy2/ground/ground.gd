extends Area2D


func _on_body_entered(body):
	SignalManager.bird_crashed.emit()
