extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var asprite = get_node("animate")

var direction = 1
var motion = Vector2()
var counter = 100
const UP = Vector2(0, -1)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	counter -= 1
	if (counter == 0) or (is_on_wall()):
		counter = 150
		direction = -1 * direction
		asprite.set_flip_h(direction == 1)
	motion.x = direction * 100
	motion = move_and_slide(motion, UP)
	pass
