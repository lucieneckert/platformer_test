extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _ready():
	show()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	play()

	

func _on_AnimatedSprite_animation_finished():
	hide()
