extends MarginContainer



func _on_Button_pressed():
	var gamesaver = load("res://GameSaver.tscn")
	var saver = gamesaver.instance()
	saver._ready()
	saver.cheat()
	get_tree().change_scene("res://world_map/Worldmap.tscn")
	pass # replace with function body
