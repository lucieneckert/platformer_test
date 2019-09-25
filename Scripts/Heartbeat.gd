extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var hp

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	hp = 4
	pass
	
func oof():
	hp -= 1
	if hp == 0:
		print("OOOOOF")
		## boot em out
		var file = File.new()
		file.open("res://sesh.txt", File.WRITE)
		file.store_line("just died")
		file.close()
		get_tree().change_scene("res://cabin-hub/Cabin.tscn")
	frame += 1

