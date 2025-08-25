extends CharacterBody2D

@export var move_distance: float = 100.0      
@export var move_speed: float = 120.0         
@export var spawn_scene: PackedScene         
	 
@export var minion_spawn_interval := Vector2(2.0, 5.0)  
@export var move_interval := Vector2(1.0, 2.0)          
var death = false
@export var health := 10.0
var start_position: Vector2
var target_position: Vector2
var moving := false
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	$AnimationPlayer.play("RESET")
	rng.randomize()
	start_position = global_position
	_schedule_move()
	_schedule_spawn()


func _physics_process(delta: float) -> void:
	if moving:
		var to_target := target_position - global_position
		if to_target.length() > 4.0:
			velocity = to_target.normalized() * move_speed
			move_and_slide()
		else:
			velocity = Vector2.ZERO
			moving = false
			_schedule_move()
	else:
		velocity = Vector2.ZERO
		


func _schedule_move() -> void:
	if death:
		return
	
	var delay := rng.randf_range(move_interval.x, move_interval.y)
	await get_tree().create_timer(delay).timeout
	$wings.play()
	var direction := 1
	if rng.randf() < 0.5:
		direction = -1

	target_position = start_position + Vector2(0, direction * move_distance)
	moving = true


func _schedule_spawn() -> void:
	if death:
		return
	var delay := rng.randf_range(minion_spawn_interval.x, minion_spawn_interval.y)
	await get_tree().create_timer(delay).timeout

	if spawn_scene:
		var minion := spawn_scene.instantiate()
		get_tree().current_scene.add_child(minion)
		minion.global_position = global_position + Vector2(0, -10)

	_schedule_spawn()  





func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if death:
		return
			 
	if body.name == "torch":
		health -= 1
		$AudioStreamPlayer2D.play()
		$CanvasLayer/ProgressBar.value -= 10
		$AnimationPlayer.play("hurt")
		await $AudioStreamPlayer2D.finished
		$AnimationPlayer.play("RESET")
		
		if health <= 0:
			death = true
			$deathScream.play()
			$AnimationPlayer.play("DEATH")
			
			
			
		
		
