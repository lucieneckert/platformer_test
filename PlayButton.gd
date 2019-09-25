extends Sprite

func _ready(delta):
	show()
	pass
	
func _process(delta):
	if (Input.is_action_just_pressed("ui_select")):
		get_tree().change_scene("res://World.tscn")
	pass