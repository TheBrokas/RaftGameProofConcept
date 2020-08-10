extends Node2D

onready var velocity = Vector2(0, 5)
onready var movement = Vector2()
onready var time = 0
var rng = RandomNumberGenerator.new()

var direction

func _ready():
	pass

func _physics_process(delta):
	time += delta
	direction = Vector2(.5 * cos(time), 1)
	movement = velocity * delta
	movement += direction
	translate(movement)
	rotation = direction.angle()

func _on_VisibilityNotifier2D_screen_exited():
	print("barrel despawned")
	queue_free()

#func RotationTimer():
	#if $RandomizationTimer.is_stopped():
		#$RandomizationTimer.start()
		#rng.randomize()
		#var my_random_number = rng.randf_range(-.5, .5)
		#direction = Vector2(cos(time * 1) + my_random_number, 1)
