extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var motion = Vector2()
var accel = Vector2()

onready var body = get_node("KinematicBody2D")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	# SETUP
	motion.x = 0
	motion.y = 0
	move_right()
	pass

func move_right():
	accel = 50
	while accel > 0:
		motion.x += accel
		accel -= 10
		var t = Timer.new()
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
	while abs(motion.x) > 0:
		var t = Timer.new()
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		motion.x -= 10
	move_left()

func move_left():
	accel = -50
	while accel < 0:
		motion.x += accel
		accel += 10
		var t = Timer.new()
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
	while abs(motion.x) > 0:
		var t = Timer.new()
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		motion.x += 10
	move_right()
	
func _physics_process(delta):
	body.move_and_slide(motion)
	print(str(motion.x) + ":" + str(motion.y))