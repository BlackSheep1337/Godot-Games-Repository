extends Area2D

var _projectile_speed: float = 350.0
var flight_direction = 0

func _process(delta):
	position.x  += flight_direction * _projectile_speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("hitbox"):
		queue_free()
