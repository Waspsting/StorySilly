extends Area2D
@export var suicide = false 
var is_in_hitbox = false
var is_yapping = false
@export_file("*.json") var dialog 
@export var group = 0 
var currentline = 0 
@onready var dialog_screen: CanvasLayer = $Dialog_screen
func _on_area_entered(_area: Area2D) -> void:
	is_in_hitbox = true 


func _on_area_exited(_area: Area2D) -> void:
	is_in_hitbox = false

func _input(_event: InputEvent) -> void:
	if(Input.is_action_just_pressed("interact")&& is_in_hitbox):
		if !is_yapping: 
			var json_data = JSON.parse_string(FileAccess.get_file_as_string(dialog))
			var clump = json_data[group]
			if currentline == len(clump):
				dialog_screen.visible = false
				currentline = 0
				if suicide:
					get_parent().queue_free()
				return 
			dialog_screen.visible = true
			dialog_screen.set_profile(clump[currentline].image)
			is_yapping = true 
			await dialog_screen.typetext(clump[currentline].text)
			is_yapping = false
			currentline += 1 
