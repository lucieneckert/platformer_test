extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var asprite = get_node("animate")

var direction = -1
var motion = Vector2()

const UP = Vector2(0, -1)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):

	if is_on_wall():

		direction = -1 * direction
		asprite.set_flip_h(direction == 1)
	motion.x = direction * 300
	motion.y = -300 + (randi()%11+1) * 50
	motion = move_and_slide(motion, UP)
	pass
