extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var can_enter = false
onready var desc = get_parent().get_node("Desc")
onready var to_load = "res://forest_tiles/forest_test.tscn"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	desc.hide()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area2D_body_entered(body):
	print("yeet")
	desc.show()
	can_enter = true
	pass # replace with function body


func _on_Area2D_body_exited(body):
	print("nope")
	can_enter = false
	desc.hide()
	pass # replace with function body

func _input(event):
	if Input.is_action_pressed("ui_select") and can_enter:
		print("Space Pressed")
		var gamesaver = load("res://GameSaver.tscn")
		var saver = gamesaver.instance()
		saver._ready()
		saver.wmap_pos(get_parent().position)
		saver.save()
		_on_Button_button_down()

func _on_Button_button_down():
	print("Pressed")
	get_parent().get_node("Ding").play(0)
	print(get_tree().change_scene(to_load))
	pass # replace with function body


func _on_AudioStreamPlayer_finished():
	print(get_tree().change_scene(to_load))
	pass # replace with function body
