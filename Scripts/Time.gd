extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var time_start
var time_current
var time_elapsed
var allow_menu

onready var menu = preload ("res://Menu.tscn")

func _ready():
	time_start = OS.get_unix_time()
	allow_menu = true
	pass

func _process(delta):
	time_current = OS.get_unix_time()
	time_elapsed = time_current - time_start
	var mins = time_elapsed / 60
	var secs = time_elapsed % 60 
	self.text = str(mins) + ":" + str(secs)
	pass
	
func _input(event):
	if Input.is_action_pressed("ui_exit") and not event.is_echo():
		print("menu")
		if allow_menu:
			add_child(menu.instance())
			allow_menu = false
