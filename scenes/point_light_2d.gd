extends PointLight2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flicker()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.



func flicker():
	energy = randf() * 0.1 + 0.9
	scale = Vector2(1, 1) * energy
	$Timer.start()
	await $Timer.timeout
	flicker()
	
