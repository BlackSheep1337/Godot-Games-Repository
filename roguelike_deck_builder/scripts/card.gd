class_name Card extends Node2D

@export var card_name: String = "Card Name"
@export var card_description: String = "Card Description"
@export var card_coast: int = 1
@export var card_image: Node2D

@onready var cost_lbl: Label = $CostDisplay/CostLbl
@onready var name_lbl: Label = $CardName/NameLbl
@onready var description_lbl: Label = $DescriptionLbl


func _ready() -> void:
	cost_lbl.set_text(str(card_coast))
	name_lbl.set_text(card_name)
	description_lbl.set_text(card_description)
	
