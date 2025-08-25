extends Node2D
@export var scenePath: NodePath

var opened = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$canvas.visible =  false




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed('E') and opened:
		opened = false
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		queue_free()
		





func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		
		$Area2D.queue_free()
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		$canvas.visible = true
		opened = true

	
		
