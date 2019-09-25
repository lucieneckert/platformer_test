extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var dia = load("res://cabin-hub/bean man/DialogBox.tscn")

func _ready():
	
	pass




func _on_Area2D_body_entered(body):
	if body == get_parent().get_node("Player"):
		get_parent().get_node("CanvasLayer").add_child(dia.instance())
		
	pass 
