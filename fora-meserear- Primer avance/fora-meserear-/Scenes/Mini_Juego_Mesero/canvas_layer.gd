extends CanvasLayer

# Referencias a tus tres nodos de corazones
@onready var corazones = [$Corazones/Corazon1, $Corazones/Corazon2, $Corazones/Corazon3]

# Referencia a tu panel de Game Over
@onready var panel_game_over = $PanelGameover

func _ready():
	# Nos aseguramos de que el panel empiece escondido al iniciar la partida
	panel_game_over.visible = false

# Esta función la llamará el mesero automáticamente cada vez que un perro lo muerda
func actualizar_corazones(vidas_restantes: int):
	# Recorremos la lista de corazones para prenderlos o apagarlos
	for i in range(corazones.size()):
		if i < vidas_restantes:
			corazones[i].visible = true
		else:
			corazones[i].visible = false
			
	# Si las vidas llegan a cero, ejecutamos el Game Over
	if vidas_restantes <= 0:
		activar_game_over()

# Función que congela el juego
func activar_game_over():
	panel_game_over.visible = true
	get_tree().paused = true # Pausa por completo el movimiento de los personajes y perros

# --- SEÑAL DEL BOTÓN ---
# Recuerda conectar la señal "pressed()" de tu nodo Button a este script.
# Al hacerlo, Godot creará el enlace directamente con esta función.
func _on_button_pressed():
	get_tree().paused = false          # Quitamos la pausa antes de reiniciar
	get_tree().reload_current_scene()  # Recarga la escena actual desde cero con las 3 vidas
