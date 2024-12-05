extends Control

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_leave_pressed() -> void:
	get_tree().quit()
