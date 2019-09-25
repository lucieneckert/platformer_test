extends KinematicBody2D

const SPEED = 200
const JUMP_HEIGHT = 550
const GRAVITY = 20
const UP = Vector2(0, -1)
const JUMPS = 2

var motion = Vector2()
var currentJumps = 0
var direction = 1
var can_jump = true




# Textures
var texture_standby = preload ("res://cat_thing_imnotanartist.png")
var texture_jump = preload ("res://cat_thing_imnotanartist_jump.png")
var texture_fall = preload("res://cat_thing_imnotanartist_fall.png")
var texture_wall = preload("res://cat_thing_imnotanartist_wall.png")
var texture_dab = preload("res://cat_thing_imnotanartist_dab.png")


var spawn_point = Vector2(-992, -300)


var just_landed = false
var can_move = true
var can_sound = true

onready var sprite = get_node("Sprite")
onready var asprite = get_node("Walking Sprite")


onready var audio_jump = get_node("jump")
onready var audio_air = get_node("air")
onready var audio_dash = get_node("dash")
onready var audio_walljump = get_node("walljump")
onready var audio_death = get_node("death")
onready var audio_land = get_node("land")



func _ready():
	asprite.hide()
	var gamesaver = load("res://GameSaver.tscn")
	var saver = gamesaver.instance()
	saver._ready()
	position = saver.get_wmap_pos()
	pass
#FIX vv

func freeze():
	can_move = false
	motion = Vector2(0,0)
	asprite.hide()
	can_jump = false

func defrost():
	can_move = true
	can_jump = true




func set_checkpoint():
	spawn_point = position

func _physics_process(delta):



	# Sprite direction
	sprite.set_flip_h(direction == -1)
	asprite.set_flip_h(direction == -1)
	if (can_move):
		asprite.show()
		if (Input.is_action_pressed("move_up")):
			motion.y = -SPEED
		elif (Input.is_action_pressed("move_down")):
			motion.y = SPEED
		else:
			motion.y = 0
		
		if Input.is_action_pressed("move_right"):
			direction = 1
			motion.x = SPEED
		elif Input.is_action_pressed("move_left"):
			direction = -1
			motion.x = -SPEED
		else:
			motion.x = 0
			
		if motion.x == 0 and motion.y == 0:
			asprite.hide()
			can_sound = true
		else:
			if can_sound:
				audio_air.play()
				can_sound = false
			
		

	
	motion = move_and_slide( motion, UP)
	#var collision
	#for i in range(get_slide_count()):
	#	collision = get_slide_collision(i)
	#	# Check damage
	#	print("Checking")
	#	if (is_enemy(collision)):
	#		motion.y += direction * -50
	#		print("OOF")
	# Jumping

	
	if (asprite.is_visible()):
		sprite.hide()
	else:
		sprite.show()





