extends CanvasLayer
var text_speed = 0.05
var is_typing = false 
func typetext (text):
	%actual_dialog.text = ""
	is_typing = true
	for character in text : 
		%actual_dialog.text += character
		await get_tree().create_timer(text_speed).timeout
	is_typing = false 
	text_speed = 0.05
	return
func _input(_event: InputEvent) -> void:
	if(Input.is_action_just_pressed("interact")&& is_typing): text_speed = 0.008
func set_profile (image): 
	%NPC_profile.texture=load(image)
