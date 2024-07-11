extends Area2D
@onready var button_sprite = $ButtonSprite


func _on_body_entered(body):
	button_sprite.frame = 1
	



func _on_body_exited(body):
	button_sprite.frame = 0



