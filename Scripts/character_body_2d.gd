extends CharacterBody2D

var speed = 70  # speed in pixels/sec

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@export var interaction_collider : CollisionShape2D
@export var starting_direction : Vector2 = Vector2(0, 1)

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	update_animation_parameters(direction)
	if(direction != Vector2.ZERO): interaction_collider.position = (15*direction)
	move_and_slide()
	
	pick_new_state()

func update_animation_parameters(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/walk/blend_position", move_input)
		animation_tree.set("parameters/idle/blend_position", move_input)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")
