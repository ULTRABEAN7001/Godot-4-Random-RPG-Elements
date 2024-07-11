extends Area2D

const SPEED = 800
@onready var wind = $Wind
var direction = Vector2.RIGHT

func _physics_process(delta):
	position += direction * SPEED * delta
	match direction:
		Vector2.UP:
			wind.rotation_degrees = 180
		Vector2.DOWN:
			wind.rotation_degrees = 0
		Vector2.LEFT:
			wind.rotation_degrees = 90
		Vector2.RIGHT:
			wind.rotation_degrees = -90
