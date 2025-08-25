extends CharacterBody2D

var speed: float = 60.0
var target = null



func _ready():
	if has_node("../torch"):
		target = get_node("../torch")
	else: 
		target = get_node("../player/hand/torch")
		
	speed *= randf()
	

func _physics_process(delta: float) -> void:
	if target == null:
		return
		

	

	var direction = sign(target.global_position - global_position)
	velocity = direction * speed
	
	move_and_slide()
	

	

	

	
	# Check every frame if the player is inside
	for body in $Area2D.get_overlapping_bodies():
		if body.name == "player":
			body.updateHealth(-1)   # scale by delta for smoother damage
	

		
