extends CharacterBody2D

@export var speed: float = 100.0
@onready var target = get_node("../torch") # path to your torch node


func _physics_process(delta: float) -> void:
	if target == null:
		return

	# Direction from monster to torch
	var direction = (target.global_position - global_position).normalized()

	# Apply movement
	velocity = direction * speed
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.updateHealth(-1)
