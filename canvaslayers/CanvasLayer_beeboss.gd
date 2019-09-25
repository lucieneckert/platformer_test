extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var boss = get_node("boss")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	boss.hide()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func show_boss():
	boss.show()
	var t = Timer.new()
	t.set_wait_time(2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	boss.hide()
	
