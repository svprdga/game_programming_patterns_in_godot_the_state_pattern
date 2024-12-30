class_name State


# Called when the machine transitions to this state
func enter() -> void:
	pass
	
	
# Called when this state ends
func exit() -> void:
	pass
	
	
# Called when there's some kind of user input
func input(_event: InputEvent) -> void:
	pass
	
	
# Called in Godot's main update cycle
func process(_delta: float) -> void:
	pass
	
	
# Called in Godot's main physics update cycle
func physics_process(_delta: float) -> void:
	pass
	
	
func get_state_name() -> String:
	push_error("Method get_state_name() must be defined.")
	return ""
