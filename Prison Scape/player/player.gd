extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var shooter = $Shooter
@onready var shooter_point = $Shooter/ShooterPoint
@onready var shoot_timer = $ShootTimer


var _projectile: PackedScene = preload("res://projectile/projectile.tscn")

@export var speed: int = 150

var _can_shoot: bool

func get_input():
	velocity.x = 0
	shooter.position.y = -23
	if Input.is_action_pressed("crouch"):
		shooter.position.y = -13
		if Input.is_action_pressed("shoot") and _can_shoot:
			animation_player.play("crouch_shooting")
			shoot()
		elif Input.is_action_pressed("left"):
			move_left()
		elif Input.is_action_pressed("right"):
			move_right()
		else:
			animation_player.play("crouch")
	elif Input.is_action_pressed("shoot") and _can_shoot:
		animation_player.play("shoot")
		shoot()
	elif Input.is_action_pressed("left"):
		move_left()
	elif Input.is_action_pressed("right"):
		move_right()
	else:
		animation_player.play("idle")

func _physics_process(_delta):
	get_input()
	move_and_slide()

func move_left() -> void:
	animation_player.play("run")
	animated_sprite_2d.flip_h = true
	shooter.rotation_degrees = 180
	velocity.x = -speed
	
func move_right() -> void:
	animation_player.play("run")
	shooter.rotation_degrees = 0
	animated_sprite_2d.flip_h = false
	velocity.x = speed

func shoot() -> void:
	set_physics_process(false)	
	var p = _projectile.instantiate()
	p.global_position = shooter_point.global_position
	get_parent().add_child(p)
	p.flight_direction = Vector2.LEFT.x if shooter.rotation_degrees > 0 else Vector2.RIGHT.x
	shoot_timer.start()
	_can_shoot = false


func _on_shoot_timer_timeout():
	set_physics_process(true)
	_can_shoot = true


func _on_player_hitbox_area_entered(area):
	print('collided')
	if area.is_in_group("wall"):
		velocity = Vector2.ZERO	
