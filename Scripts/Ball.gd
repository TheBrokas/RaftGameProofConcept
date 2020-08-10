extends Area2D

const velocity = 300
var movement = Vector2()
var direction

func _ready():
	direction = get_global_mouse_position() - position
	direction = direction.normalized()

func _physics_process(delta):
	movement = velocity * direction * delta
	translate(movement)

