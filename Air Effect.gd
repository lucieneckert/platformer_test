extends AnimatedSprite



func _process(delta):
	if (get_frame() == 5):	
		stop()
		hide()
	if self.is_visible():
		play()
	else:
		self.hide()
	if !(self.is_playing()):
		set_frame(0)

	pass

func trigger(pos):
	pos.y += 5
	pos.x -= 2
	set_position(pos)
	pass
	
func mode(param):
	if (param == "dash"):
		rotation = 3.14 / 2
	else:
		rotation = 0
	pass