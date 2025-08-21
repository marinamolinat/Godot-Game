extends RigidBody2D

@onready var playerBody = get_node("../player")

var equiped = false

	

func pickup():
	if playerBody == null:
		return
	
	get_parent().remove_child(self)
	playerBody.get_node("hand").add_child(self)
	position = Vector2.ZERO 
	self.rotation = deg_to_rad(90)
	self.freeze = true
	
	
func throw(direction: Vector2, strength: float = 40.0):
	if playerBody == null:
		return

	var world = get_tree().current_scene

	# Save current global transform
	var old_transform = global_transform

	# Reparent
	get_parent().remove_child(self)
	world.add_child(self)

	# Restore so it doesn’t snap to (0,0)
	global_transform = old_transform

	# Re-enable physics
	freeze = false
 
	# Apply impulse
	apply_impulse(direction.normalized() * strength, Vector2.ZERO)

	
		
	
	
	
   

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("torch "):
		if not equiped:
			equiped = true
			pickup()
		else: 
			throw(Vector2(playerBody.direction, 0), 400)
			equiped = false
		
			

			
		




	
		
