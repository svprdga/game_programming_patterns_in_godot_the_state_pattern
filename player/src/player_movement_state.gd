class_name PlayerMovementState extends PlayerState


static var state_name = "PlayerMovementState"

const ACCELERATION: float = 20
const MAX_SPEED: float = 150


func get_state_name() -> String:
	return state_name
	
	
func process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		main_state_machine.transition(PlayerJumpState.state_name)
		pass
	
	animation_player.play("run")
	player.handle_facing()
	
	
func physics_process(_delta: float) -> void:
	var input: float = player.horizontal_input * ACCELERATION
	
	# Detect absence of input to exit state
	if input == 0.0:
		main_state_machine.transition(PlayerIdleState.state_name)
		pass
	
	# Process movement
	player.velocity.x += input
	player.velocity.x = clamp(player.velocity.x, -MAX_SPEED, MAX_SPEED)
