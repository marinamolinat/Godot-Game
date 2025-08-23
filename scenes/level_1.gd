extends Node2D



	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not $AudioStreamPlayer2D.playing:
		var probability := 0.01 * delta  
		if randf() < probability:
			$AudioStreamPlayer2D.play()
	
