extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var sprite = get_node("Sprite")
onready var area = get_node("Area2D")
onready var ding = get_node("ding")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_process(true)
	pass


func _on_Area2D_body_entered(body):
	if body == get_parent().get_node("Player"):
		## INC SCORE
		ding.play(0)
		area.position.x = 69000
		sprite.hide()
		get_tree().change_scene("res://cabin-hub/Cabin.tscn")
	pass # replace with function body
