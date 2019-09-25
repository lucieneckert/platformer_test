extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var body = get_node("KinematicBody2D")
onready var sprite = body.get_node("Sprite")

const COUNTER = 200

var idle = preload("res://hazards/jumper/00.png")
var jump = preload("res://hazards/jumper/01.png")
var counter = COUNTER
var direction = 1

var motion = Vector2()
var check_after_jump = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	sprite.set_texture(idle)
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	motion.y += 20

	counter -= 1
	if counter <= 0:
		counter = COUNTER
		jump()
		position.y -= 10
	motion = body.move_and_slide(motion)
	if abs(motion.y) <= 1 and check_after_jump:
		print("he landed")
		motion.x = 0
		motion.y = 0
		sprite.set_texture(idle)
		sprite.flip_h = not sprite.flip_h
		check_after_jump = false
#	pass


func jump():
	sprite.set_texture(jump)
	motion.y = -550
	motion.x = 200 * direction
	direction = -direction
	check_after_jump = true
	
	
	
