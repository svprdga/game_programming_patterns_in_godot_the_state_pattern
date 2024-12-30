class_name PlayerController extends CharacterBody2D


enum Facing {
	LEFT,
	RIGHT
}

var horizontal_input: float = 0

var _facing: Facing = Facing.RIGHT
var _gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_player = $AnimationPlayer
@onready var main_state_machine = $MainStateMachine
@onready var sprite = $Sprite2D


func _ready() -> void:
	var states: Array[State] = [PlayerIdleState.new(self), PlayerMovementState.new(self), PlayerJumpState.new(self)]
	main_state_machine.start_machine(states)


func _physics_process(delta: float) -> void:	
	horizontal_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

	# Always apply gravity
	if not is_on_floor():
		velocity.y += _gravity * delta
		main_state_machine.transition(PlayerJumpState.state_name)

	move_and_slide()
	
	
func handle_facing() -> void:
	var flip: int = 0
	
	if horizontal_input < 0.0:
		flip = 1
	elif horizontal_input > 0.0:
		flip = -1

	# Apply facing
	var _old_facing: Facing = _facing
	
	if flip == -1:
		sprite.flip_h = false
		_facing = Facing.RIGHT
	elif flip == 1:
		sprite.flip_h = true
		_facing = Facing.LEFT	
