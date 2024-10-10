extends CharacterBody2D

class_name Player


const SPEED = 700.0
const JUMP_VELOCITY = -500.0

var moon_rocks_collected: int = 0
var moon_rocks_needed_to_transform: int = 20

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func collect_moon_rock() -> void:
	if enough_moon_rocks():
		grow_up()
	moon_rocks_collected += 1

func enough_moon_rocks() -> bool:
	return moon_rocks_collected >= moon_rocks_needed_to_transform

func grow_up() -> void:
	scale = Vector2(2.0,2.0)
