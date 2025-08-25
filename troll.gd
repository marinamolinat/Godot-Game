extends CharacterBody2D

var speed: float = 20.0
@onready var target = get_node("../torch") # path to your torch node
@onready var lastX = position.x
var jumpForce = -150


func _physics_process(delta: float) -> void:
	if target == null:
		return
		
	if not is_on_floor():
		velocity += get_gravity() * delta
	

	var direction_x = sign(target.global_position.x - global_position.x)
	velocity.x = direction_x * speed
	
	move_and_slide()
	
	if abs(lastX - position.x) < 0.5 and is_on_floor():
		velocity.y = jumpForce
	

	
	lastX = position.x
	

	for body in $Area2D.get_overlapping_bodies():
		if body.name == "player":
			body.updateHealth(-2)   
	
