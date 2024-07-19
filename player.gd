extends CharacterBody2D

const SPEED = 25000.0
@onready var player_sprite = $PlayerSprite
var inertia = 4500
@onready var box_direction_ref = $BoxDirectionRef
var boxdir = Vector2.ZERO
@onready var directioner = $Direction
@onready var actionable_finder = $Direction/ActionableFinder



func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return
	
	#Movement related Code
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction.normalized() * SPEED * delta
		
	match direction:
		Vector2.UP:
			player_sprite.frame = 1
			box_direction_ref.rotation_degrees = 180
			directioner.rotation_degrees = 180
			boxdir = Vector2.UP
		Vector2.DOWN:
			player_sprite.frame = 0
			box_direction_ref.rotation_degrees = 0
			directioner.rotation_degrees = 0
			boxdir = Vector2.DOWN
		Vector2.LEFT:
			player_sprite.frame = 3
			box_direction_ref.rotation_degrees = 90
			directioner.rotation_degrees = 90
			boxdir = Vector2.LEFT
		Vector2.RIGHT:
			player_sprite.frame = 2
			box_direction_ref.rotation_degrees = -90
			directioner.rotation_degrees = -90
			boxdir = Vector2.RIGHT
	move_and_slide()
	
	#This prevents it from going diagonally
	if box_direction_ref.is_colliding(): 
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if collision.get_collider() is RigidBody2D:
				collision.get_collider().apply_central_force(boxdir * inertia)
	
	#Bullet Firing
	if Input.is_action_just_pressed("interact"):
		var bullet = preload("res://wind_bullet.tscn").instantiate()
		bullet.direction = boxdir
		bullet.global_position = self.global_position
		add_sibling(bullet)
		
	if Input.is_action_just_pressed("debug_test"):
		get_tree().change_scene_to_file("res://battle.tscn")
	
