extends Node

enum ColorType {
	RED,
	GREEN,
	BLUE
}

func get_rand_rgb_color() -> Color:
	var random_color_index = randi_range(0, 2)
	var new_color: Color
	match GameManager.ColorType.values()[random_color_index]:
		GameManager.ColorType.RED:
			new_color = Color(1.0, 0.0, 0.0, 1.0)
		GameManager.ColorType.GREEN:
			new_color = Color(0.0, 1.0, 0.0, 1.0)
		GameManager.ColorType.BLUE:			
			new_color = Color(0.0, 0.0, 1.0, 1.0)
	return new_color
