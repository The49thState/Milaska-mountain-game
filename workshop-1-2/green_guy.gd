extends CharacterBody2D

const SPEED = 250.0
var JUMP_VELOCITY = -500.0
var on_ladder := false
@onready var BlueGuy = get_node('../Blue guy')

func _physics_process(delta: float) -> void:
	
	if on_ladder:
		velocity.y = 0
		
		if Input.is_action_pressed("up"):
			velocity.y = -SPEED
		elif Input.is_action_pressed("down"):
			velocity.y = SPEED
		else:
			velocity.y = 0

		if Input.is_action_pressed("left"):
			velocity.x = -SPEED
		elif Input.is_action_pressed("right"):
			velocity.x = SPEED
		else:
			velocity.x = 0	


	else:
		if not is_on_floor():
			velocity += get_gravity() * delta

		if Input.is_action_just_pressed("up") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		if Input.is_action_pressed("left"):
			velocity.x = -SPEED
		elif Input.is_action_pressed("right"):
			velocity.x = SPEED
		else:
			velocity.x = 0

	if BlueGuy != null:
		var distance = global_position.distance_to(BlueGuy.position)
		if distance > 400.0 :
			print("blue guy 1")
			JUMP_VELOCITY = 0
		else:
			print('blue guy 2')
			JUMP_VELOCITY = -500

				
				
				
	move_and_slide()
	
func die():
	get_tree().reload_current_scene()
func WIN():
	get_tree().reload_current_scene()
	
	
	
func _on_ladder_body_entered(body):
	if body == self:
		on_ladder = true

func _on_ladder_body_exited(body):
	if body == self:
		on_ladder = false
