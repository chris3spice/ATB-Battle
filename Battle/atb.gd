extends Node2D

#PRELOAD
const ATB_UNIT = preload("res://battle/atb_unit.tscn")

#Array of players
var players : Array = [BattleManager.player, BattleManager.opponent]

var waiting_length : float
var activation_length : float
var recovery_length : float
@onready var start: Marker2D = $Markers/Start
@onready var choice: Marker2D = $Markers/Choice
@onready var action: Marker2D = $Markers/Action
@onready var end: Marker2D = $Markers/End

@onready var units: Node2D = $Units
@onready var action_bar: Control = $ActionBar

func _ready() -> void:
	BattleManager.connect("pause", pause)
	BattleManager.connect("unpause", unpause)
	waiting_length = choice.position.x - start.position.x
	activation_length = action.position.x - choice.position.x
	recovery_length = end.position.x - action.position.x
	#Create new battle unit and pass in information
	for i in players:
		var new_atb_unit = ATB_UNIT.instantiate()
		new_atb_unit.battle_unit = i
		new_atb_unit.start_mark = start
		new_atb_unit.choice_mark = choice
		new_atb_unit.action_mark = action
		new_atb_unit.waiting_length = waiting_length
		new_atb_unit.activation_length = activation_length
		new_atb_unit.recovery_length = recovery_length
		units.add_child(new_atb_unit)

func pause(player):
	for n in units.get_children():
		n.pause_timers()

func unpause():
	for n in units.get_children():
		n.unpause_timers()
