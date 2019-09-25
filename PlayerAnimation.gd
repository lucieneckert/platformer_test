extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var norm_frames = preload("res://cat_walk/norm_frames.tres")
onready var bee_frames = preload("res://cat_walk/bee_frames.tres")

var elapsed = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	play()
	#	elapsed += delta
	
	#	if (elapsed > 0.5):
	#		if(get_frame() == self.get_sprite_frames().get_frame_count() - 1):
	#			set_frame(0)
	#		else:
	#			set_frame(get_frame() + 1)
	pass