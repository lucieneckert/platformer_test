extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var test = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func died():
	test = true

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
