extends MarginContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var vine_menu = get_child(0).get_child(0).get_node("vine_menu")
onready var desc = get_child(0).get_child(0).get_node("Label")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	vine_menu.hide()
	desc.hide()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button_pressed(): ##vines
	vine_menu.show()
	pass # replace with function body


func _on_Button_pressed_forest_begin(): ## explore
	get_parent().get_parent().load_forest()
	pass # replace with function body


func _on_chungus_pressed():
	get_parent().get_parent().get_node("Player").scale = Vector2(2,2)
	pass # replace with function body


func _on_vine_explore_Button_pressed():
	desc.show()
	desc.text = "Explore Vine Grotto and scope out the locations of all the trophies."
	pass # replace with function body
