extends CollisionShape2D

func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		body.die()
	pass # replace with function body
