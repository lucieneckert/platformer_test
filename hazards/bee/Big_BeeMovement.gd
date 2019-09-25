extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var asprite = get_node("animate")
onready var player = get_parent().get_node("Player")
onready var roar = get_node("roar")
onready var roar2 = get_node("roar2")
onready var tongue = get_node("tongue base")
onready var sprite_phaseone = load("res://hazards/big/phaseone.tres")
onready var sprite_phasetwo = load("res://hazards/big/phasetwo.tres")
onready var clayer = get_parent().get_node("CanvasLayer")


var direction = 1
var motion = Vector2()
var speed = SPEED
var speed_counter = 300
var tongue_counter = 100
var intro = false
var phase_three = false
var shake_loops = 1

const UP = Vector2(0, -1)
const RANDOMVAL = 50
const SPEED = 150

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	asprite.set_sprite_frames(sprite_phaseone)
	pass
	
func get_player_dist():
	var px = player.position.x
	var py = player.position.y
	var x = self.position.x
	var y = self.position.y
	var o = px - x

	return [o, y - py]
	
func animate_three():
	shake_loops = 3
	SPEED = 250
	speed_counter = 100
	roar2.play()
	asprite.set_sprite_frames(sprite_phasetwo)

func _process(delta):
	
	motion.x = direction * speed
	var i = shake_loops
	while(i > 0):
		motion.y = -300 + (randi()%11+1) * RANDOMVAL
		i -=1
	if shake_loops == 3:
		motion.y *= 3
	var pdist_data = get_player_dist()
	if (not intro) and pdist_data[0] < 1400:
		intro = true
		clayer.show_boss()
		get_parent().get_node("boss_theme").play(0)
	if pdist_data[0] > 1000:
		speed_counter -= 1
		if speed_counter <= 0:
			roar.play(0)
			speed = 400
			speed_counter = 300
	else:
		speed = SPEED
	if pdist_data[0] < 1500:
		tongue_counter -= 1
	if tongue_counter <= 0 and self.position.x > 7500:
		tongue.attack()
		tongue_counter = 400
	if pdist_data[1] > 150:
		motion.y -= 50
	elif pdist_data[1] < -150:
		motion.y += 50
		
	motion = move_and_slide(motion, UP)
	
	if position.x > 15200 and phase_three == false:
		phase_three = true
		animate_three()
	
	pass
