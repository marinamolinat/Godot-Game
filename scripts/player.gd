extends CharacterBody2D

var health = 3
const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var lastDirection = -1
var hasKey = false

var direction := 1

@onready var heart = preload("res://scenes/heart.tscn")
@onready var effects = $effects
@onready var animations = $AnimatedSprite2D
@onready var hurtTimer = $hurtTimer
@onready var deathTimer = $deathTimer
@onready var hurtSound = $hurtSound


func _ready ():
	
	drawHearts()
	effects.play("RESET")
	

func drawHearts():
	var parent = $CanvasLayer/HBoxContainer
	
	#clear all hearts
	parent.get_children().map(func(c): c.queue_free())

	#Draws current health
	for i in range(health):
		var inst = heart.instantiate()
		parent.add_child(inst)

	




		

func updateHealth(n: int):
	if not is_inside_tree():
		return 
	
	if $hurtTimer.is_stopped():
		health += n
		drawHearts()

		if n < 0:
			
			#death :(
			if health <= 0:
				$CollisionShape2D.queue_free()
				$deathSound.play()
				$deathTimer.start()
				await $deathTimer.timeout
				get_tree().reload_current_scene()
				
			
			effects.play("damage")
			hurtSound.play()
			$hurtTimer.start()
			await $hurtTimer.timeout
			
			
			
			
			
		effects.play("RESET")
		
		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if  Input.is_action_pressed("left"):
		direction = -1
	elif Input.is_action_pressed("right"):
		direction = 1
	else: 
		direction = 0



		
		
	if direction:
		
		animations.play("walk")
		
		if direction != lastDirection:
			lastDirection = direction
			self.scale.x = -self.scale.x
			
		velocity.x = direction * SPEED
	else:
		animations.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
