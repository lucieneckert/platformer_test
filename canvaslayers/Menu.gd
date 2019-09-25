extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	print("menu loaded")
	# Called when the node is added to the scene for the first time.
	# Initialization here
	self.position = Vector2(220,150)
	get_tree().paused = true
	pass




func _on_Restart_pressed():
	print("restart level")
	get_tree().paused = false
	get_tree().reload_current_scene()
	pass # replace with function body


func _on_Exit_pressed():
	print("leave scene")
	get_tree().paused = false
	get_tree().change_scene("res://world_map/Worldmap.tscn")
	pass # replace with function body
	
func _input(event):
	if Input.is_action_pressed("ui_exit") and not event.is_echo():
		print("closing menu")
		hide()
		var t = Timer.new()
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		get_parent().allow_menu = true
		get_tree().paused = false
		get_parent().remove_child(self)
		
