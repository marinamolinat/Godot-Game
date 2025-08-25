extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	

	await get_tree().create_timer(40.0).timeout
	get_tree().change_scene_to_file("res://scenes/intro.tscn")
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/intro.tscn")
