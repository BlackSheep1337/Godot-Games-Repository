extends CharacterBody2D
class_name Player

const max_speed: int = 500
const acceleration: int = 1500
const friction: int = 600
var input = Vector2.ZERO
var fibonacci_sequence := [0, 1]

func _physics_process(delta) -> void:
	basket_moviment(delta)


func get_input() -> Vector2:
	input.x = int(Input.is_action_just_pressed("right")) - int(Input.is_action_just_pressed("left"))
	return input.normalized()
	
func basket_moviment(delta) -> void:
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity.x += (input.x * acceleration)
		velocity = velocity.limit_length(max_speed)
	
	move_and_slide()


func _on_timer_timeout():
	modulate = GameManager.get_rand_rgb_color()

func calculate_next_fibonacci() -> void:
	var next_fibonacci = fibonacci_sequence[-1] + fibonacci_sequence[-2]
	fibonacci_sequence.append(next_fibonacci)
