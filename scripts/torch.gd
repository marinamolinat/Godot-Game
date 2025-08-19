extends RigidBody2D

var pickUp = false
var playerBody = null
var equiped = false
# Called when the node enters the scene tree for the first time.


func pickup():
	if playerBody == null:
		return
	
	get_parent().remove_child(self)
	playerBody.get_node("hand").add_child(self)
	position = Vector2.ZERO 
	self.rotation = deg_to_rad(90)
	self.freeze = true
	$Area2D/CollisionShape2D.disabled = true
	
func throw(direction: Vector2, strength: float = 400.0):
	if playerBody == null:
		return
	  # 1. Reparent to the world (usually to the main scene root or a "World" node)
	var world = get_tree().current_scene
	get_parent().remove_child(self)
	world.add_child(self)

		# 2. Re-enable physics
	self.freeze = false
	 
	linear_velocity = direction.normalized() * strength
	$Area2D/CollisionShape2D.disabled = false
		
	
	
	
   

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pickUp and Input.is_key_pressed(KEY_E):
		pickUp = false
		pickup()
		equiped = true
	elif equiped and Input.is_key_pressed(KEY_D):
		throw(Vector2(100, 1000), 4011.1)
	
		
			
		




func _on_area_2d_body_entered(body: Node2D) -> void:
	playerBody = body
	pickUp = true
	
		
