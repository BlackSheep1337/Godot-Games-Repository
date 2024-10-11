extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var explode_animation: PackedScene = preload("res://enemies/Explode/explode_animation.tscn")

var _health: float = 40.0
var _damage: float = 10.0
var _damage_taken: float = 5.0
var _player_in_area: bool = false
var _player

enum AnimationState {
	IDLE,
	ATTACK,
	HURT
}

var _current_animation_state = AnimationState.IDLE

func _process(_delta):
	if !isDead():
		$detection/detectionCollisionShape.disabled = false
		if _player_in_area:
			_current_animation_state = AnimationState.ATTACK
			var player_direction = (_player.global_position - global_position).normalized()
			if player_direction.x < 0:
				animated_sprite_2d.flip_h = true
			else:
				animated_sprite_2d.flip_h = false
		else:
			if _current_animation_state != AnimationState.HURT:
				_current_animation_state = AnimationState.IDLE
	else:
		$detection/detectionCollisionShape.disabled = true
		die()

	update_animation()
	
func isDead() -> bool:
	return _health <= 0

func die() -> void:
	var exp_anim = explode_animation.instantiate()
	exp_anim.global_position = global_position
	get_parent().add_child(exp_anim)
	queue_free()

func update_animation():
	match _current_animation_state:
		AnimationState.IDLE:
			animated_sprite_2d.play("Idle")
		AnimationState.ATTACK:
			animated_sprite_2d.play("Attack")
		AnimationState.HURT:
			if not animated_sprite_2d.is_playing():
				_current_animation_state = AnimationState.IDLE


func _on_detection_body_entered(body):
	if body.is_in_group("player"):
		_player_in_area = true
		_player = body

func _on_detection_body_exited(body):
	if body.is_in_group("player"):
		_player_in_area = false

func _on_hitbox_area_entered(area):
	if area.is_in_group("projectile"):
		_health -= _damage_taken
		if _current_animation_state != AnimationState.HURT:
			_current_animation_state = AnimationState.HURT
			animated_sprite_2d.play("Hurt")
