extends TextureButton

@onready var progress_bar: TextureProgressBar = $TextureProgressBar
@onready var timer: Timer = $Timer
@onready var time: Label = $Time
@onready var key: Label = $Key
@onready var info: Label = $Info

var move_resource
 
var change_key = "":
	set(value):
		change_key = value
		key.text = value
 
		shortcut = Shortcut.new()
		var input_key = InputEventKey.new()
		input_key.keycode = value.unicode_at(0)
 
		shortcut.events = [input_key]
 
func _ready():
	info.text = move_resource.move_name
	info.visible = false
	change_key = "1"
	progress_bar.max_value = timer.wait_time
	set_process(false)
 
func _process(_delta):
	time.text = "%3.1f" % timer.time_left
	progress_bar.value = timer.time_left
 
func _on_pressed():
	timer.start()
	disabled = true
	set_process(true)
 
	BattleManager.move_selected.emit(move_resource)
 
 
func _on_timer_timeout():
	disabled = false
	time.text = ""
	set_process(false)
	
func disable():
	disabled = true
	
func enable():
	disabled = false

func _on_mouse_entered() -> void:
	info.visible = true

func _on_mouse_exited() -> void:
	info.visible = false
