extends Control
var settings = Settings.new()
var tempsettings = Settings.new()
var audio = AudioServer.get_bus_index("Master")

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_leave_pressed() -> void:
	get_tree().quit()

# Settings bullshit from here on

func _on_options_pressed() -> void:
	$AudioStreamPlayer.play()
	$optionsmenu.visible = true



func _on_back_pressed() -> void:
	$AudioStreamPlayer.play()
	$optionsmenu.visible = false
	settings.loaddata()
	AudioServer.set_bus_volume_db(audio, linear_to_db(settings.options["volume"]))
	if settings.options["fullscreen"] == true :
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else : 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	$optionsmenu/HSlider.value = settings.options["volume"]
	$optionsmenu/Label.text = "volume = " + str($optionsmenu/HSlider.value * 100) + "%"
	$optionsmenu/CheckBox.button_pressed = settings.options["fullscreen"]


func _on_apply_pressed() -> void:
	$AudioStreamPlayer.play()
	settings.options = tempsettings.options
	settings.savedata()
	AudioServer.set_bus_volume_db(audio, linear_to_db(settings.options["volume"]))
	if settings.options["fullscreen"] == true :
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else : 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)



func _on_h_slider_drag_ended(_value_changed: bool) -> void:
	AudioServer.set_bus_volume_db(audio, linear_to_db($optionsmenu/HSlider.value))
	$AudioStreamPlayer.play()
	$optionsmenu/Label.text = "volume = " + str($optionsmenu/HSlider.value * 100) + "%"
	tempsettings.options["volume"] = $optionsmenu/HSlider.value


func fullscreen_on(toggled_on: bool) -> void:
	$AudioStreamPlayer.play()
	if toggled_on == true :
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else : 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	tempsettings.options["fullscreen"] = toggled_on

func _ready ():
	settings.loaddata()
	$optionsmenu/HSlider.value = settings.options["volume"]
	$optionsmenu/Label.text = "volume = " + str($optionsmenu/HSlider.value * 100) + "%"
	$optionsmenu/CheckBox.button_pressed = settings.options["fullscreen"]
