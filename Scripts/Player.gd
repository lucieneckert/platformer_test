extends KinematicBody2D

const SPEED = 300
const JUMP_HEIGHT = 550
const GRAVITY = 20
const UP = Vector2(0, -1)
const JUMPS = 2

const BEE_SPEED = 270
const BEE_JUMP_HEIGHT = 420 
const BEE_GRAVITY = 15
const BEE_JUMPS = 4

# Form const vars
var current_form = "NORM"
var current_speed = SPEED
var current_jump_height = JUMP_HEIGHT
var current_gravity = GRAVITY
var current_max_jumps = JUMPS


var motion = Vector2()
var currentJumps = 0
var direction = 1
var can_jump = true




# Textures
var norm_texture_standby = preload ("res://cat_thing_imnotanartist.png")
var norm_texture_jump = preload ("res://cat_thing_imnotanartist_jump.png")
var norm_texture_fall = preload("res://cat_thing_imnotanartist_fall.png")
var norm_texture_wall = preload("res://cat_thing_imnotanartist_wall.png")


var bee_texture_standby = preload ("res://bee_suit/beesuit.png")
var bee_texture_jump = preload ("res://bee_suit/beesuit_jump.png")
var bee_texture_fall = preload("res://bee_suit/beesuit_fall.png")
var bee_texture_wall = preload("res://bee_suit/beesuit_wall.png")

var bee_walk_frames = preload("res://cat_walk/bee_frames.tres")
var norm_walk_frames = preload("res://cat_walk/norm_frames.tres")

# Texture states
var texture_standby = norm_texture_standby
var texture_jump = norm_texture_jump
var texture_fall = norm_texture_fall
var texture_wall = norm_texture_wall

var spawn_point = Vector2(-992, -300)


var just_landed = false
var can_move = true

onready var sprite = get_node("Sprite")
onready var asprite = get_node("Walking Sprite")
onready var air_effect = get_parent().get_node("Air Effect")
onready var long_boye = get_parent().get_node("Long Boye")
onready var audio_jump = get_node("jump")
onready var audio_air = get_node("air")
onready var audio_dash = get_node("dash")
onready var audio_walljump = get_node("walljump")
onready var audio_death = get_node("death")
onready var audio_land = get_node("land")
onready var snake = get_parent().get_node("snake")
onready var health = get_parent().get_node("CanvasLayer").get_node("Hearts").get_node("Hearts")
onready var form_change_effect = get_node("FormChangeEffect")
onready var ground_effect = get_node("ground_effect")
onready var audio_pup = get_node("pup")

#MISC 
var current_asprite = asprite


func _ready():
	asprite.hide()
	air_effect.hide()
	form_change_effect.hide()
	ground_effect.hide()
	pass
	spawn_point = position
#FIX vv

func freeze():
	can_move = false
	motion = Vector2(0,0)
	asprite.hide()
	can_jump = false

func defrost():
	can_move = true
	can_jump = true

func die():
	audio_death.play(0)
	position = spawn_point
	if not get_parent().get_node("CanvasLayer").get_node("Hearts").get_node("Hearts") == null:
		health.oof()

func set_checkpoint():
	spawn_point = position

#CHANGE FORMS
func _unhandled_input(event):
	var changing = false
	##FORM CHANGE
	if Input.is_action_pressed("form_change_1"):
		## Check if revert
		if current_form == "BEE":
			current_form = "NORM"
			currentJumps -= BEE_JUMPS - JUMPS
		else:
			current_form = "BEE"
			currentJumps = BEE_JUMPS - JUMPS + currentJumps
		changing = true
	## ADD MORE FORMS HERE
	if changing:
		audio_pup.play(0)
		form_change_effect.show()
		form_change_effect.frame = 0
		form_change_effect.play()
		if current_form == "BEE":
			current_speed = BEE_SPEED
			current_jump_height = BEE_JUMP_HEIGHT
			current_gravity = BEE_GRAVITY
			current_max_jumps = BEE_JUMPS
			texture_standby = bee_texture_standby
			texture_jump = bee_texture_jump
			texture_fall = bee_texture_fall
			texture_wall = bee_texture_wall
			asprite.set_sprite_frames(bee_walk_frames)
		if current_form == "NORM":
			current_speed = SPEED
			current_jump_height = JUMP_HEIGHT
			current_gravity = GRAVITY
			current_max_jumps = JUMPS
			texture_standby = norm_texture_standby
			texture_jump = norm_texture_jump
			texture_fall = norm_texture_fall
			texture_wall = norm_texture_wall
			asprite.set_sprite_frames(norm_walk_frames)

func get_form():
	return current_form

func get_current_jumps():
	if currentJumps < 0:
		return 0
	else:
		return currentJumps

func _physics_process(delta):
	

	motion.y += current_gravity

	# Sprite direction
	sprite.set_flip_h(direction == -1)
	asprite.set_flip_h(direction == -1)
	if (can_move):
		if (Input.is_action_pressed("move_right")):
			if(motion.x < current_speed):
				motion.x += current_speed
			else:
				motion.x = current_speed
			direction = 1
			if(is_on_floor()):
				asprite.show()
		elif (Input.is_action_pressed("move_left")):
			if(motion.x > current_speed):
				motion.x -= current_speed
			else:
				motion.x = -current_speed
			direction = -1
			if(is_on_floor()):
				asprite.show()
		else:
			asprite.hide()
			if (motion.x >  50):
				motion.x -= current_speed / 3
			elif (motion.x < -50):
				motion.x += current_speed / 3
			else:
				motion.x = 0

	if(Input.is_action_just_pressed("dash")):
		audio_dash.play(0)
		motion.x = direction * current_speed * 2
		air_effect.mode("dash")
		air_effect.show()
		air_effect.trigger(self.get_position())
		var t = Timer.new()
		rotation = 45 * -direction
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		can_move = false
		t.start()
		yield(t, "timeout")
		can_move = true
		rotation = 0

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

	if ( is_on_floor() ):

		# Set ground texture
		sprite.set_texture(texture_standby)

		if just_landed == true:
			audio_land.play(0)
			just_landed = false
			ground_effect.show()
			ground_effect.frame = 0
			ground_effect.play()
		motion.y = 0
		currentJumps = current_max_jumps - 1

		if(Input.is_action_pressed("jump") and can_jump):

			audio_jump.play(0)
			motion.y = -current_jump_height

	elif(is_on_wall()):
		if motion.y > 0:
			motion.y -= 5
		if(Input.is_action_just_pressed("jump")):
			audio_walljump.play(0)
			motion.y = -current_jump_height * 4 / 5
			direction = direction * -1
			motion.x = direction * current_speed * 1.5
			var t = Timer.new()
			t.set_wait_time(0.3)
			t.set_one_shot(true)
			self.add_child(t)
			can_move = false
			t.start()
			yield(t, "timeout")
			can_move = true

	elif (Input.is_action_just_pressed("jump")):

		if (currentJumps > 0):
			air_effect.mode("jump")
			air_effect.show()
			audio_air.play(0)
			air_effect.trigger(self.get_position())
			if current_form == "NORM":
				motion.y = -current_jump_height * 3 / 4
			if current_form == "BEE":
				motion.y = -current_jump_height * 2 / 4
			currentJumps -=1

	# Wall Jump


	if(motion.y > 0):
		asprite.hide()
		if(is_on_wall()):
			sprite.set_texture(texture_wall)
		else:
			sprite.set_texture(texture_fall)
			just_landed = true
	elif(motion.y < 0):
		sprite.set_texture(texture_jump)
		asprite.hide()

	if (asprite.is_visible()):
		sprite.hide()
	else:
		sprite.show()







func _on_FormChangeEffect_animation_finished():
	form_change_effect.hide()
	pass # replace with function body


func _on_ground_effect_animation_finished():
	ground_effect.hide()
	pass # replace with function body
