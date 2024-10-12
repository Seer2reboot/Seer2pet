extends CharacterBody2D

@onready var body = $body
var playback

const WIN_SIZE = Vector2(500, 450) 
#必备数据
var dragging = false
var mouse_in_pos:Vector2
var win_pos:Vector2
var mouse_pos:Vector2
var display_id:int = -999 #显示器id
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().root.borderless = true
	get_tree().root.transparent = true
	get_tree().root.transparent_bg = true
	get_tree().get_root().size = WIN_SIZE
	var lf = load_file()
	var data = JSON.parse_string(lf)
	if (data.cid) == 1:
		var player = get_node("body")
		player.play("main")
	if (data.cid) == 2:
		var player = get_node("body")
		player.play("dlc1")
	if (data.cid) == 3:
		var player = get_node("body")
		player.play("dlc2")
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			dragging = true
			mouse_in_pos = get_viewport().get_mouse_position()
		else:
			dragging = false
	if event is InputEventMouseMotion and dragging:
		mouse_pos = get_viewport().get_mouse_position()
		get_tree().get_root().position = get_screen_pos() + mouse_pos - mouse_in_pos
		

func get_screen_pos():
	return Vector2(get_tree().get_root().position)
func load_file():
	pass
	var file = FileAccess.open("data.json", FileAccess.READ)
	var content = file.get_as_text()
	print(content)
	return content
