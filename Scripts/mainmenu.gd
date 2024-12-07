extends Control

var audio = AudioServer.get_bus_index("Master")

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_leave_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
	$AudioStreamPlayer.play()
	$optionsmenu.visible = true 


func _on_back_pressed() -> void:
	$AudioStreamPlayer.play()
	$optionsmenu.visible = false
	



func _on_h_slider_drag_ended(value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(audio, linear_to_db($optionsmenu/HSlider.value))
	$AudioStreamPlayer.play()
	$optionsmenu/Label.text = "volume = " + str($optionsmenu/HSlider.value * 100) + "%"


func fullscreen_on(toggled_on: bool) -> void:
	$AudioStreamPlayer.play()
	if toggled_on == true :
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else : 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
