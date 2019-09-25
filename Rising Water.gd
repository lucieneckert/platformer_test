extends Node

const RISE_SPEED = -200

var motion = Vector2()

func _ready(delta):
	motion.y = RISE_SPEED
	pass
	
func _process(delta):
	translate(motion)
	pass