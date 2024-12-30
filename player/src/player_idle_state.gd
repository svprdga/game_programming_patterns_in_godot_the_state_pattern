class_name PlayerIdleState extends PlayerState


static var state_name = "PlayerIdleState"

const STOP_FORCE: float = 15


func process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		main_state_machine.transition(PlayerJumpState.state_name)
		pass
	
	animation_player.play("idle")
	player.handle_facing()


func physics_process(_delta: float) -> void:
	if player.horizontal_input != 0.0:
		main_state_machine.transition(PlayerMovementState.state_name)
		pass
		
	# Apply stop force if it's moving
	if player.velocity.x != 0.0:
		player.velocity.x = move_toward(player.velocity.x, 0, STOP_FORCE)
		
		
func get_state_name() -> String:
	return state_name
