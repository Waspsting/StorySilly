extends Control
var settings = Settings.new()
var tempsettings = Settings.new()
var audio = AudioServer.get_bus_index("Master")

func start() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func leave() -> void:
	get_tree().quit()


# Settings bullshit from here on
func options() -> void:
	%SFX.play()
	$options_menu.visible = true

# Updates the settings.
func update():
	AudioServer.set_bus_volume_db(audio, linear_to_db(settings.options["volume"]))
	if settings.options["fullscreen"] == true :
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else : 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	%volume_slider.value = settings.options["volume"]
	%volume.text = str(%volume_slider.value * 100) + "%"
	%fullscreen_check.button_pressed = settings.options["fullscreen"]

func back() -> void:
	%SFX.play()
	$options_menu.visible = false
	settings.loaddata()
	update()


func apply() -> void:
	%SFX.play()
	settings.options = tempsettings.options
	settings.savedata()
	update()


func volume_set(value_changed: bool) -> void:
	if value_changed:
		AudioServer.set_bus_volume_db(audio, linear_to_db(%volume_slider.value))
		%SFX.play()
		%volume.text = str(%volume_slider.value * 100) + "%"
		tempsettings.options["volume"] = %volume_slider.value

var db = false # 'db' stands for debounce. This is so this function isn't called possibly ever frame, which is bad for performance.
func volume_changing(value : float):
	if !db:
		db = true # This prevents the function from being called again.
		%volume.text = str(%volume_slider.value * 100) + "%"
		get_tree().create_timer(0.05).timeout.connect(func(): db = false) 
		# This creates a timer that lasts 0.05s. Once finished, it calls a a lambda function that allows the function to be called again. 

func fullscreen_on(toggled_on: bool) -> void:
	%SFX.play()
	if toggled_on == true :
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else : 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	tempsettings.options["fullscreen"] = toggled_on

func _ready ():
	settings.loaddata()
	update()

func _process(_delta: float) -> void:
	var volume_text : String = %volume.text
	var volume_text_value = int(volume_text.trim_suffix("%"))
	if !(%volume_slider.value * 100) == volume_text_value: # This is to make sure that the text and slider don't get desynced.
		%volume.text = str(%volume_slider.value * 100) + "%"
	
