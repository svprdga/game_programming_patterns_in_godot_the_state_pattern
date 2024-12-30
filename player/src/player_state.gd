class_name PlayerState extends State


var player: PlayerController
var animation_player: AnimationPlayer
var main_state_machine: StateMachine


func _init(player_controller: PlayerController) -> void:
	player = player_controller
	animation_player = player.animation_player
	main_state_machine = player.main_state_machine
