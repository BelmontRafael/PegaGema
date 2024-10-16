extends Node2D

class_name Jogo

const EXPLODE = preload("res://GemCatcherAssets/explode.wav")

@export var gema_scene: PackedScene
@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var _score: int = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_spawn_gema()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Função de spawnar gemas e mudar a posiçao do spawn da gema de maneira aleatoria
func _spawn_gema() -> void:
	var new_gema: Gema = gema_scene.instantiate()
	var random_x: float = randf_range(70, 1050)
	new_gema.gema_fora_tela.connect(_game_over) #Conecta o sinal a funcao game over
	new_gema.position = Vector2(random_x, -50)
	add_child(new_gema) #adiciona a cena ao no raiz 

#Funcao para parar todas as cenas/timer
func stop_all() -> void:
	timer.stop()
	audio_stream_player.stop()
	for child in get_children():
		child.set_process(false)
	
#Explodir ao perder
func explode() -> void:
	audio_stream_player_2d.stop()
	audio_stream_player_2d.stream = EXPLODE
	audio_stream_player_2d.play()

#Game Over
func _game_over() -> void:
	stop_all()
	explode()

# Sinal timout do timer, utilizaremos como spawnar gemas a cada periodo de tempo
func _on_timer_timeout() -> void:
	_spawn_gema()

# Aumentar score e liberar a gema da cena
func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 1 
	label.text = "%03d" % _score #
	audio_stream_player_2d.position = area.position #recebe a posicao da area que colide para o som sair nessa "posicao"
	audio_stream_player_2d.play()
	area.queue_free()
