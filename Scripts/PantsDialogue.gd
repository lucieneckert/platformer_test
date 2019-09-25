extends RichTextLabel

var dialog = ["Hey. How's it going. You can call me Mr. Pants.","I wear pants."]
var page = 0
var counter = 0
onready var sound = get_node("sound")
onready var box = get_parent()
onready var cabin = get_parent().get_parent().get_parent()
onready var menu = load("res://cabin-hub/PantsCheats.tscn")


func _ready():
	var file = File.new()
	file.open("res://sesh.txt", File.READ)
	var sesh_data = file.get_line()


	print(sesh_data)
	if str(sesh_data) == "just died":
		dialog = ["Wow. You really fucking died huh.","That sucks."]
	set_bbcode(dialog[page])
	set_visible_characters(0)
	get_parent().get_parent().get_parent().get_node("Player").freeze()
	
	
	pass
	
func _input(event):
	if Input.is_action_pressed("ui_select") and not event.is_echo():
			if get_visible_characters() < dialog[page].length():
				set_visible_characters(dialog[page].length())
			else:
				page += 1
				set_visible_characters(0)
				if page == dialog.size():
					cabin.get_node("CanvasLayer").add_child(menu.instance())
					get_parent().get_parent().remove_child(get_parent())
					get_parent().remove_child(self)
				else:
					set_bbcode(dialog[page])
				
func _physics_process(delta):
	counter += 1
	if counter % 3 == 0 && get_visible_characters() < dialog[page].length():
		set_visible_characters(get_visible_characters() + 1)
		sound.play(0)
		
