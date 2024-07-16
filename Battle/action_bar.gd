extends HBoxContainer

const MOVE_BUTTON = preload("res://battle/move_button.tscn")

var skills : Array
 
func _ready():
	BattleManager.connect("pause", pause)
	BattleManager.connect("unpause", unpause)
	for i in BattleManager.player.moveset:
		var new_move = MOVE_BUTTON.instantiate()
		new_move.move_resource = i
		add_child(new_move)
	
	skills = get_children()
	for i in get_child_count():
		skills[i].change_key = str(i+1)
		

func pause(player):
	for i in get_child_count():
		skills[i].timer.paused = true
		if player: #If players turn enable the buttons
			skills[i].disabled = false
	
func unpause():
	for i in get_child_count():
		skills[i].timer.paused = false
		skills[i].disabled = true #Disable the players buttons
