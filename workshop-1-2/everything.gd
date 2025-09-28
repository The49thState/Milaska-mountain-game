extends Node2D

@onready var GreenGuy = get_node('Green guy/Icon')
@onready var BlueGuy = get_node('Blue guy/sprite')
@onready var Rope = get_node('Line2D')
 
func _process(_delta):
	print("g")
	Rope.points = [ 
		BlueGuy.global_position, 
		GreenGuy.global_position
	]
	
