extends CharacterBody2D

const SPEED = 400.0
var JUMP_VELOCITY = -500.0
@onready var GreenGuy = get_node('../Green guy')

func _physics_process(delta: float) -> void:
	
	if not is_on_floor ():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("LEFT"): 
		velocity.x = -150
	
	elif Input.is_action_pressed("RIGHT"): 
			velocity.x = 150
			
	else:
		velocity.x = 0

	if GreenGuy != null:
		var distance = global_position.distance_to(GreenGuy.global_position)
		print(distance)
		if distance > 400.0 :
			print("gr guy 1")
			JUMP_VELOCITY = 0
			
		else:
			print('gr guy 2')
			JUMP_VELOCITY = -500

	move_and_slide()
	 
func die():
	get_tree().reload_current_scene()
	
func WIN():
	get_tree().reload_current_scene()

func _on_ladder_player_entered(plawawadwddwadawdayer: Variant) -> void:
	pass


func _on_ladder_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_ladder_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
