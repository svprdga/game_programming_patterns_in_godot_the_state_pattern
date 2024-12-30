class_name StateMachine extends Node


@export var is_log_enabled: bool = false

var is_running: bool = false

var current_state: State
var states: Dictionary = {}
var _parent_node_name: String


# Start this state machine
func start_machine(init_states: Array[State]) -> void:
	_parent_node_name = get_parent().name
	
	for state in init_states:
		states[state.get_state_name()] = state

	current_state = init_states[0]
	
	if is_log_enabled:
		print("[%s]: Entering state \"%s\"" % [_parent_node_name, current_state.get_state_name()])
	
	current_state.enter()
	is_running = true
	
	
func _input(event: InputEvent) -> void:
	current_state.input(event)
	
	
func _process(delta: float) -> void:
	current_state.process(delta)
	
	
func _physics_process(delta: float) -> void:
	current_state.physics_process(delta)
	

# Attempt a transition to the new state.
# @param new_state The name of the new state to transition to.
func transition(new_state_name: String) -> void:	
	var new_state: State = states.get(new_state_name)
	var current_state_name = current_state.get_state_name()

	if new_state == null:
		push_error("An attempt has been made to transition to a non-existent state (%s)." % new_state_name)
	elif new_state != current_state:
		
		if is_log_enabled:
			print("[%s]: Exiting state \"%s\"" % [_parent_node_name, current_state_name])
		
		current_state.exit()
		current_state = states[new_state.get_state_name()]
		
		if is_log_enabled:
			print("[%s]: Entering state \"%s\"" % [_parent_node_name, current_state.get_state_name()])
		
		current_state.enter()
	else:
		push_warning("An attempt to transition to the current state has been made. Ignoring request.")
