extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var level_clear_data = []
var wmap_pos = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	print("THIS RAN")
	var file = File.new()
	var line = ""
	var data = ""
	if not file.file_exists("res://save.txt"):
		file.open("res://save.txt", File.WRITE)
		file.store_line("lvlclr:0,0,0,0,0,0")
		file.store_line("wmap_pos:200,190")
		file.close()
	file.open("res://save.txt", File.READ)
	while not file.eof_reached():
		line = file.get_line()
		line = line.split(":")
		if line[0] == "lvlclr":
			data = line[1]
			print(data)
			level_clear_data = data.split(",")
		if line[0] == "wmap_pos":
			data = line[1].split(",")
			print(int(data[0]))
			wmap_pos.x = int(data[0])
			wmap_pos.y = int(data[1])
			print(wmap_pos)
			

	pass


func check_level(levelnum):
	return level_clear_data[levelnum - 1] == "1"

func update_level_to_cleared(levelnum):
	print(level_clear_data)
	level_clear_data[levelnum - 1] = "1"
	
func wmap_pos(pos):
	print(pos)
	wmap_pos = pos

func get_wmap_pos():
	return wmap_pos
	
	
func save():
	var file = File.new()
	var output_lvlclr = ""
	output_lvlclr = "lvlclr:"
	for level in level_clear_data:
		output_lvlclr += str(level) + ","
	var output_wmap_pos = "wmap_pos:" + str(wmap_pos.x) + "," + str(wmap_pos.y)
	file.open("res://save.txt", File.WRITE)
	file.store_line(output_lvlclr)
	file.store_line(output_wmap_pos)
	file.close()
	
func cheat():
	var file = File.new()
	var output_lvlclr = ""
	output_lvlclr = "lvlclr:1,1,1,1,1,1,1,1,1,1,1,1,1,1,1"
	var output_wmap_pos = "wmap_pos:" + str(wmap_pos.x) + "," + str(wmap_pos.y)
	file.open("res://save.txt", File.WRITE)
	file.store_line(output_lvlclr)
	file.store_line(output_wmap_pos)
	file.close()
	
		
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
