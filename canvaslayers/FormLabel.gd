extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const PREF = "Current Form: "
const JUMPS_PREF = "Current Jumps: "
onready var player = get_parent().get_parent().get_node("Player")
 
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	text = PREF
	pass

func _process(delta):
	text = PREF + player.get_form() + "\n" + JUMPS_PREF + str(player.get_current_jumps())
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
