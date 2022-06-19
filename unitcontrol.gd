extends Control

export var count = 0
export var chance = 0
onready var game = get_node("/root/Node2D")

func _ready():
	$ColorRect/CHANCE.text = ("%2.0f" % chance) + "%"
	add_to_group("champ")
	$Label.text = str(count)

func _on_Control_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			count += 1
			game._on_Button_pressed()
		elif event.button_index == BUTTON_RIGHT and event.pressed:
			count -= 1
			game._on_Button_pressed()
	$Label.text = str(count)

func update_vis():
	$ColorRect/CHANCE.text = ("%2.2f" % chance) + "%"
	$Label.text = str(count)#
	
