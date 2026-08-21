extends Control

# Obtenemos la referencia al nuevo reproductor de efectos
@onready var sfx_player = $SFXPlayer

func _ready() -> void:
	# Cargamos el archivo de sonido del hover en el reproductor
	sfx_player.stream = load("uid://bf3hgaw3hkro7")
	
	# Buscamos y guardamos la referencia de los tres botones
	var btn_iniciar = get_node_or_null("VBoxContainer/HBoxContainer/NewGameBtn")
	var btn_opciones = get_node_or_null("VBoxContainer/HBoxContainer/SettingsBtn")
	var btn_salir = get_node_or_null("VBoxContainer/HBoxContainer/ExitBtn")
	
	# Conectamos las funciones de clic y de hover si los botones existen
	if btn_iniciar:
		btn_iniciar.pressed.connect(_on_new_game_pressed)
		btn_iniciar.mouse_entered.connect(_on_button_hover)
		
	if btn_opciones:
		btn_opciones.mouse_entered.connect(_on_button_hover)
		# Aquí conectarás la función de opciones cuando la crees
		
	if btn_salir:
		btn_salir.pressed.connect(_on_exit_pressed)
		btn_salir.mouse_entered.connect(_on_button_hover)

# Función única que se ejecuta cuando el mouse pasa por encima de cualquier botón
func _on_button_hover() -> void:
	if sfx_player and sfx_player.stream:
		sfx_player.play()

func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("uid://kwv47ngy00ke")

func _on_exit_pressed() -> void:
	get_tree().quit()
