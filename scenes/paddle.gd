extends Area2D

class_name Paddle

@export var speed: float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Movimentação pros lados!
	#position.x += speed * delta * Input.get_axis("Esquerda", "Direita")
	if Input.is_action_pressed("Direita"):
		position.x += speed * delta
	if Input.is_action_pressed("Esquerda"):
		position.x -= speed * delta
	
