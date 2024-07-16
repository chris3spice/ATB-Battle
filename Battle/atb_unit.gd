extends Node2D

@onready var waiting_timer: Timer = $waiting_timer
@onready var activation_timer: Timer = $activation_timer
@onready var recovery_timer: Timer = $recovery_timer
@onready var icon: Marker2D = $Icon

var battle_unit
#Here for testing
@export var speed : float = 4.0
@export var activation_time : float = 2.0
@export var recovery_time : float = 2.0

var start_mark
var choice_mark
var action_mark
var waiting_length
var activation_length
var recovery_length

var where : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	waiting_timer.wait_time = battle_unit.speed
	activation_timer.wait_time = activation_time
	recovery_timer.wait_time = recovery_time
	
	where = "waiting"
	waiting_timer.start()

func _process(delta: float) -> void:
	match where:
		"waiting":
			icon.position.x = ((waiting_length/(waiting_timer.wait_time/waiting_timer.time_left))*-1)
			icon.position.x += waiting_length+start_mark.position.x
			icon.position.y = start_mark.position.y
		"activation":
			icon.position.x = ((activation_length/(activation_timer.wait_time/activation_timer.time_left))*-1)
			icon.position.x += activation_length+choice_mark.position.x
			icon.position.y = choice_mark.position.y
		"recovery":
			icon.position.x = ((recovery_length/(recovery_timer.wait_time/recovery_timer.time_left))*-1)
			icon.position.x += recovery_length+action_mark.position.x
			icon.position.y = action_mark.position.y

func _on_waiting_timer_timeout() -> void:
	print("Makes choice")
	BattleManager.pause.emit(battle_unit.is_player) #Emit pause and if player initiated
	where = "activation"
	activation_timer.start()

func _on_activation_timer_timeout() -> void:
	#Chaomon goes into recovery phase
	BattleManager.pause.emit(false) #Stops buttons from becoming active
	print("execute move and recover")
	BattleManager.unpause.emit()
	where = "recovery"
	recovery_timer.start()

func _on_recovery_timer_timeout() -> void:
	#Chaomon goes into waiting phase
	print("reset")
	where = "waiting"
	waiting_timer.start()

func pause_timers():
	waiting_timer.paused = true
	activation_timer.paused = true
	recovery_timer.paused = true
	
func unpause_timers():
	waiting_timer.paused = false
	activation_timer.paused = false
	recovery_timer.paused = false
