extends KinematicBody2D

const SPEED = 280
const JUMP_HEIGHT = 420
const GRAVITY = 15
const UP = Vector2(0, -1)
const JUMPS = 4

var motion = Vector2()
var currentJumps = 0
var direction = 1
var can_jump = true




# Textures
var texture_standby = preload ("res://bee_suit/beesuit.png")
var texture_jump = preload ("res://bee_suit/beesuit_jump.png")
var texture_fall = preload("res://bee_suit/beesuit_fall.png")
var texture_wall = preload("res://bee_suit/beesuit_wall.png")



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

func _ready():
	asprite.hide()
	air_effect.hide()
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

func _physics_process(delta):

	motion.y += GRAVITY

	# Sprite direction
	sprite.set_flip_h(direction == -1)
	asprite.set_flip_h(direction == -1)
	if (can_move):
		if (Input.is_action_pressed("move_right")):
			if(motion.x < SPEED):
				motion.x += SPEED
			else:
				motion.x = SPEED
			direction = 1
			if(is_on_floor()):
				asprite.show()
		elif (Input.is_action_pressed("move_left")):
			if(motion.x > SPEED):
				motion.x -= SPEED
			else:
				motion.x = -SPEED
			direction = -1
			if(is_on_floor()):
				asprite.show()
		else:
			asprite.hide()
			if (motion.x >  50):
				motion.x -= SPEED / 3
			elif (motion.x < -50):
				motion.x += SPEED / 3
			else:
				motion.x = 0

	if(Input.is_action_just_pressed("dash")):
		audio_dash.play(0)
		motion.x = direction * SPEED * 1.5
		motion.y = JUMP_HEIGHT * 4 / 5
		air_effect.mode("dash")
		air_effect.show()
		air_effect.trigger(self.get_position())
		var t = Timer.new()
		rotation = 45 * direction
		t.set_wait_time(0.4)
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
		motion.y = 0
		currentJumps = JUMPS - 1

		if(Input.is_action_pressed("jump") and can_jump):

			audio_jump.play(0)
			motion.y = -JUMP_HEIGHT

	elif(is_on_wall()):
		if motion.y > 0:
			motion.y -= 5
		if(Input.is_action_just_pressed("jump")):
			audio_walljump.play(0)
			motion.y = -JUMP_HEIGHT * 4 / 5
			direction = direction * -1
			motion.x = direction * SPEED * 1.5
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
			motion.y = -JUMP_HEIGHT * 2 / 4
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





