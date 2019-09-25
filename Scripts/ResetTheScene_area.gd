extends CollisionPolygon2D

var can_kill = true

func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.name == 'Player' and can_kill:
		print("RESET")
		print(self.name)
		print(self.get_parent().name)
		print(self.get_parent().get_parent().name)
		get_tree().reload_current_scene()
	pass # replace with function body
