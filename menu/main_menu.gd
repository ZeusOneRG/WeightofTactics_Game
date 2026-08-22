extends Control

# Obtenemos la referencia al reproductor de efectos
@onready var sfx_player = $SFXPlayer

# Definimos el color de iluminación (un naranja brillante/óxido)
const HOVER_COLOR = Color(1.5, 0.8, 0.3)
const NORMAL_COLOR = Color(1.0, 1.0, 1.0)

func _ready() -> void:
	# Mantiene el menú funcionando si el juego se pausa
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Cargamos el archivo de sonido del hover en el reproductor
	sfx_player.stream = load("uid://bf3hgaw3hkro7")
	
	# RUTAS CORREGIDAS: Empezamos directamente desde "MarginContainer"
	var btn_iniciar = get_node_or_null("MarginContainer/VBoxContainer2/btn_newgame")
	var btn_cargar = get_node_or_null("MarginContainer/VBoxContainer2/btn_loadgame")
	var btn_new3 = get_node_or_null("MarginContainer/VBoxContainer2/btn_newgame3")
	var btn_new4 = get_node_or_null("MarginContainer/VBoxContainer2/btn_newgame4")
	var btn_salir = get_node_or_null("MarginContainer/VBoxContainer2/btn_exit")
	
	# Verificación de seguridad en la consola por si acaso
	if not btn_iniciar:
		print("¡ERROR: No se encontraron los botones! Revisa los nombres exactos.")
		
	# Creamos un array con todos los botones para conectar las señales
	var todos_los_botones = [btn_iniciar, btn_cargar, btn_new3, btn_new4, btn_salir]
	
	for boton in todos_los_botones:
		if boton:
			# Conectamos los efectos visuales y de sonido usando Callable
			boton.mouse_entered.connect(func(): _on_button_hover(boton))
			boton.mouse_exited.connect(func(): _on_button_exited(boton))
			
	# Conexiones particulares para las acciones de clic
	if btn_iniciar:
		btn_iniciar.pressed.connect(_on_new_game_pressed)
	if btn_salir:
		btn_salir.pressed.connect(_on_exit_pressed)

# Al entrar el mouse: reproduce sonido e ilumina el botón específico
func _on_button_hover(boton: Control) -> void:
	if sfx_player and sfx_player.stream:
		sfx_player.play()
	var tween = create_tween()
	tween.tween_property(boton, "modulate", HOVER_COLOR, 0.1)

# Al salir el mouse: devuelve el botón a su color original
func _on_button_exited(boton: Control) -> void:
	var tween = create_tween()
	tween.tween_property(boton, "modulate", NORMAL_COLOR, 0.1)

func _on_new_game_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("uid://kwv47ngy00ke")

func _on_exit_pressed() -> void:
	get_tree().quit()

# NUEVO: Detecta Escape de forma segura sin alterar tus componentes visuales
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		# Alterna la visibilidad solo si lo usás dentro del nivel
		visible = !visible
		get_tree().paused = visible
