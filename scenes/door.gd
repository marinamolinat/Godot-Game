extends Area2D
var isOpened = false
var inside = false
@export_file("*.tscn") var scenePath: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if inside and isOpened:
		if Input.is_action_pressed('E'):
			get_tree().change_scene_to_file(scenePath)
			


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if body.hasKey == true and not isOpened:
			inside = true
			$open.play()
			#do more open stuff
			$openingTimer.start()
			await $openingTimer.timeout
			
			if inside: 
				$AnimatedSprite2D.play("open")
				isOpened = true
			
		elif not body.hasKey:
			$locked.play()
			


func _on_body_exited(body: Node2D) -> void:
	if body.name == "player" and isOpened:
		inside = false
		$openingTimer.start()
		await $openingTimer.timeout
		if not inside:
			$AnimatedSprite2D.play("closed")
			$close.play()
			isOpened = false
		
		
