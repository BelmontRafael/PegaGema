extends Area2D

class_name Gema

signal gema_fora_tela     #sinal de game_over, deve ser emitido quando a gema sair da viewport.

@export var speed: float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta     #comando pra gema cair
	
	if position.y > get_viewport_rect().size.y:    #se a posicao y da gema for maior que o tamanho y da viewport, o processo acaba e a gema é liberada da cena.
		gema_fora_tela.emit()
		set_process(false)
		queue_free()
