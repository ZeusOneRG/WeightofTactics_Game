extends Control

@onready var btn_newgame: TextureButton = %btn_newgame
@onready var btn_loadgame: TextureButton = %btn_loadgame
@onready var btn_savegame: TextureButton = %btn_savegame
@onready var btn_settings: TextureButton = %btn_settings
@onready var btn_exit: TextureButton = %btn_exit

@onready var btn_effect: AudioStreamPlayer2D = %btn_effect
@onready var menu_music: AudioStreamPlayer2D = %menu_music

const HOVER_COLOR = Color(1.5, 0.8, 0.3)
const NORMAL_COLOR = Color(1.0, 1.0, 1.0)

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	menu_music.stream = load("uid://dawda2tphdpyw")
	menu_music.play()
	
	var all_buttons = [btn_newgame, btn_loadgame, btn_savegame, btn_settings, btn_exit]
	
	for buttons in all_buttons:
		if buttons:
			buttons.mouse_entered.connect(func(): _on_button_hover(buttons))
			buttons.mouse_exited.connect(func(): _on_button_exited(buttons))
	
	if btn_newgame: 
		btn_newgame.pressed.connect(_on_new_game_pressed)
	if btn_exit: 
		btn_exit.pressed.connect(_on_exit_pressed)

func _on_button_hover(boton: Control) -> void:
	if btn_effect and btn_effect.stream:
		btn_effect.play()
	var tween = create_tween()
	tween.tween_property(boton, "modulate", HOVER_COLOR, 0.1)

func _on_button_exited(boton: Control) -> void:
	var tween = create_tween()
	tween.tween_property(boton, "modulate", NORMAL_COLOR, 0.1)

func _on_new_game_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("uid://kwv47ngy00ke")

func _on_exit_pressed() -> void:
	get_tree().quit()

#Under review it isnt working on lvl scene
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		visible = !visible
		get_tree().paused = visible
