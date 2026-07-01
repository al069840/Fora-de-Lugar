extends CharacterBody2D

@export var VELOCIDAD = 200.0
var numero_plato_actual = 0  # 0 significa manos vacías

func _physics_process(_delta):
	var direccion_x = 0
	var direccion_y = 0
	
	# Usamos Input.is_physical_key_pressed, que lee el teclado directamente por hardware
	if Input.is_physical_key_pressed(KEY_RIGHT) or Input.is_physical_key_pressed(KEY_D):
		direccion_x = 1
		$PlatoCargado.position = Vector2(80, -100)
		
	elif Input.is_physical_key_pressed(KEY_LEFT) or Input.is_physical_key_pressed(KEY_A):
		direccion_x = -1
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
	
	# =========================================================
	# CONTROL DE ANIMACIONES Y AJUSTE DE TAMAÑO (ESCALA CORREGIDA)
	# =========================================================
	if direccion_y > 0:
		$AnimatedSprite2D.play("Abajo")
		# -------------------------------------------------------------
		# CORREGIDO: Reducimos a la mitad (0.5) porque el sprite base es muy grande.
		# Si notas que queda muy chico o muy grande, calíbralo a 0.55 o 0.6
		# -------------------------------------------------------------
		$AnimatedSprite2D.scale = Vector2(0.9, 0.9)
		
		$PlatoCargado.position = Vector2(0, -38)
		$PlatoCargado.z_index = 1
		$TextoPlatoCargado.z_index = 1
		
	elif direccion_y < 0:
		$AnimatedSprite2D.play("Arriba")
		# Reducimos también a la mitad cuando va hacia atrás
		$AnimatedSprite2D.scale = Vector2(0.9, 0.9) 
		
		$PlatoCargado.position = Vector2(0, -50)
		$PlatoCargado.z_index = -1  # Esconde el plato tras la espalda
		$TextoPlatoCargado.z_index = -1
		
	elif direccion_x > 0:
		$AnimatedSprite2D.play("Derecha")
		$AnimatedSprite2D.scale = Vector2(1.0, 1.0) # Vuelve al tamaño original (100%)
		$PlatoCargado.z_index = 1
		$TextoPlatoCargado.z_index = 1
		
	elif direccion_x < 0:
		$AnimatedSprite2D.play("Izquierda")
		$AnimatedSprite2D.scale = Vector2(1.0, 1.0) # Vuelve al tamaño original (100%)
		$PlatoCargado.z_index = 1
		$TextoPlatoCargado.z_index = 1
		
	else:
		$AnimatedSprite2D.play("Quieto")
		$AnimatedSprite2D.scale = Vector2(1.0, 1.0) # Vuelve al tamaño original (100%)
		$PlatoCargado.position = Vector2(0, -38)
		$PlatoCargado.z_index = 1
		$TextoPlatoCargado.z_index = 1
