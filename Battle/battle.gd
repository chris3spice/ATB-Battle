extends CanvasLayer

var player_move : move
var opponent_move : move

func _ready() -> void:
	BattleManager.move_selected.connect(_move_selected)
	BattleManager.pause.connect(_pause)
	
func _move_selected(move_resource):
	player_move = move_resource
	BattleManager.unpause.emit()

func _pause(player):
	#If its not the player we need AI to make a choice
	if !player:
		#Pick random move from opponent moveset
		opponent_move = BattleManager.opponent.moveset.pick_random()
		BattleManager.unpause.emit()
