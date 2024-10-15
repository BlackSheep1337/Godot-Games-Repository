extends ParallaxBackground

@onready var speed: int = 250

func _process(delta):
	scroll_offset.x -= speed * delta
