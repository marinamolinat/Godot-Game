extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../CanvasLayer/TextureRect".visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "player":
		body.hasKey = true
		$"../AudioStreamPlayer2D".play()
		$"../CanvasLayer/TextureRect".visible = true
		queue_free()
