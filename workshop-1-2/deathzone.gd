extends Area2D

func _physics_process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	
	for body in overlapping_bodies:
		if body.name == "Blue guy" or "Green guy": 
			body.die()  
