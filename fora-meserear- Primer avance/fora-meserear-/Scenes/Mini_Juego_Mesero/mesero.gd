extends CharacterBody2D

@export var VELOCIDAD = 200.0  # Ya cambiado a export como lo hicimos antes
var numero_plato_actual = 0  # 0 significa manos vacías

func _physics_process(_delta):
	var direccion_x = 0
	var direccion_y = 0
	
	# Usamos Input.is_physical_key_pressed, que lee el teclado directamente por hardware
	if Input.is_physical_key_pressed(KEY_RIGHT) or Input.is_physical_key_pressed(KEY_D):
		direccion_x = 1
		# =========================================================
		# AJUSTADO: Mano derecha (X adelante, Y justo en la bandeja)
		# =========================================================
		$PlatoCargado.position = Vector2(80, -100)
		
	elif Input.is_physical_key_pressed(KEY_LEFT) or Input.is_physical_key_pressed(KEY_A):
		direccion_x = -1
		# =========================================================
		# CORREGIDO: Mano izquierda (X en NEGATIVO para cambiar de lado)
		# =========================================================
		$PlatoCargado.position = Vector2(-80, -100)
		
	if Input.is_physical_key_pressed(KEY_DOWN) or Input.is_physical_key_pressed(KEY_S):
		direccion_y = 1
	elif Input.is_physical_key_pressed(KEY_UP) or Input.is_physical_key_pressed(KEY_W):
		direccion_y = -1
	
	# Aplicamos el movimiento
	velocity.x = direccion_x * VELOCIDAD
	velocity.y = direccion_y * VELOCIDAD
	
	move_and_slide()
	position.x = clamp(position.x, 40, 960)
	position.y = clamp(position.y, 230, 575)
	
	# REGRESAN LAS ANIMACIONES
	if velocity.x > 0:
		$AnimatedSprite2D.play("Derecha")
	elif velocity.x < 0:
		$AnimatedSprite2D.play("Izquierda")
	elif velocity.y != 0:
		# Si solo se mueve hacia arriba o abajo, que use la animación de caminar de lado
		$AnimatedSprite2D.play("Derecha")
		# Mantiene el plato en la mano derecha correspondientemente
		$PlatoCargado.position = Vector2(32, -42)
	else:
		# Si dejas de presionar todo, se queda quieto de frente
		$AnimatedSprite2D.play("Quieto")
		# Centramos el plato un poco en sus manos delanteras mientras espera
		$PlatoCargado.position = Vector2(0, -38)
