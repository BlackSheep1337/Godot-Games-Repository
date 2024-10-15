extends RigidBody2D

var speed = 10;
var force = 150;


	
func multiply(num1, num2):
	if num2 == 0:
		return "multiplicador não pode ser 0";
	return num1 * num2;
	
func _ready():
	print(multiply(8, 0));
		
func  _physics_process(_delta):
	if Input.is_action_pressed("move_right"):
		apply_force(Vector2(force * speed, 0));
	elif Input.is_action_pressed("move_left"):
		apply_force(Vector2(-force * speed, 0));
	elif Input.is_action_pressed("move_up"):
		apply_force(Vector2(0, -force * speed));
	elif Input.is_action_pressed("move_down"):
		apply_force(Vector2(0, force * speed));
