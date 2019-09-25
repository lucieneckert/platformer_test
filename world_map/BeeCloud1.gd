extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var gamesaver = load("res://GameSaver.tscn")
	var saver = gamesaver.instance()
	saver._ready()
	if saver.check_level(1):
		print("clear")
		get_parent().call_deferred("remove_child", self)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
