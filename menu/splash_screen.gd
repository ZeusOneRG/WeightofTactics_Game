extends Control

# Ruta de la escena principal a la que queremos ir
const MAIN_SCENE_PATH = "uid://bfp1eekrf7ej2"

func _ready() -> void:
	# Conectamos la señal del temporizador por código
	$Timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	# Cambiamos a la escena principal al pasar los 3 segundos
	get_tree().change_scene_to_file(MAIN_SCENE_PATH)
	
