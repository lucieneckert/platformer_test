extends KinematicBody2D

onready var asprite = get_node("animate")

var direction = -1
var motion = Vector2()
const UP = Vector2(0, -1)

func _ready():
	asprite.play()
	pass
	
func _physics_process(delta):
	motion.y += 10
	if(is_on_wall()):
		direction = -1 * direction
		asprite.set_flip_h(direction == 1)
		motion.x = 150 * direction
		motion = move_and_slide( motion, UP)
	else:
		motion.x = 150 * direction
		motion = move_and_slide( motion, UP)
	pass
	