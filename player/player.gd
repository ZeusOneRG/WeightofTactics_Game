extends CharacterBody2D

@export var speed: float = 300.0

# Referencias a los nodos de tu escena
@onready var chassis: Sprite2D = $chassis
@onready var turret_axis: Node2D = $turret_axis

func _physics_process(_delta: float) -> void:
	# 1. MOVIMIENTO EN TODAS LAS DIRECCIONES (Usando tus acciones personalizadas)
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	# 2. ROTACIÓN DEL CHASIS (El chasis mira hacia donde camina)
	if direction != Vector2.ZERO:
		chassis.rotation = direction.angle()
		
	# 3. ROTACIÓN DE LA TORRETA (Gira 360 grados apuntando al mouse)
	var mouse_position = get_global_mouse_position()
	turret_axis.look_at(mouse_position)
