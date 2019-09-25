extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var can_enter = false
onready var desc = get_parent().get_node("Desc")
onready var to_load = "res://woods/woods_2.tscn"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	desc.hide()
	get_parent().get_node("trophy").hide()
	var gamesaver = load("res://GameSaver.tscn")
	var saver = gamesaver.instance()
	saver._ready()
	if saver.check_level(7):
		print("clear")
		get_parent().get_node("trophy").show()
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
	can_enter = false
	desc.hide()
	pass # replace with function body

func _input(event):
	if Input.is_action_pressed("ui_select") and can_enter:
		var gamesaver = load("res://GameSaver.tscn")
		var saver = gamesaver.instance()
		saver._ready()
		saver.wmap_pos(get_parent().position)
		saver.save()
		_on_Button_button_down()

func _on_Button_button_down():
	get_parent().get_node("Ding").play(0)
	print(get_tree().change_scene(to_load))
	pass # replace with function body


func _on_AudioStreamPlayer_finished():
	get_tree().change_scene(to_load)
	pass # replace with function body
