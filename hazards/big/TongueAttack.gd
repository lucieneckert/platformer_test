extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var player = get_parent().get_parent().get_node("Player")
onready var tongue = get_node("tongue")
onready var sound = get_node("sound")
onready var hitbox = get_node("Area2D/CollisionPolygon2D")

var STARTPOS = Vector2()

var movement  = ""
var motion = 0
var motiony = 0
var dx = 0
var dy = 0

func _ready():
	hide()
	hitbox.can_kill = false
	STARTPOS = self.position
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
	
func attack():
	hitbox.can_kill = true
	self.position = STARTPOS
	show()
	var y = player.position.y - self.position.y
	var x = player.position.x - self.position.x
	var h = sqrt(pow(x, 2) + pow(y,2))
	var a = asin(y/h)
	self.rotation = a
	dx = cos(a)
	dy = sin(a)

	var t = Timer.new()
	t.set_wait_time(0.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	movement = "forward"
	sound.play(0)
	t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	movement = "backward"
	t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	movement = ""
	hide()
	self.position = STARTPOS
	self.rotation = 0
	hitbox.can_kill = false
		
	
func _process(delta):
	
	if movement == "forward":
		motion = 0.8 * dx
		motiony = 0.8 * dy
	elif movement == "backward":
		motion = -4 * dx
		motiony = -4 * dy
	else:
		motion = 0
	self.position.x += motion
	self.position.y += motiony
	
		
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
