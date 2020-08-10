extends Node2D

var BARREL = load("res://Scenes/Items/Barrel.tscn")
var rng = RandomNumberGenerator.new()
var spawn_position_x

func _ready():
	pass 

func _physics_process(delta):
	barrel_spawning()

func barrel_spawning():
	if $BarrelTimer.is_stopped():
		RngTimer()
		var spawn_position_x = rng.randf_range(10, 1000)
		print("Barrel Spawning")
		$BarrelTimer.start()
		var barrel = BARREL.instance()
		barrel.position.x = spawn_position_x
		add_child(barrel)

func RngTimer():
	rng.randomize()
	var my_random_number = rng.randf_range(2, 4)
	$BarrelTimer.wait_time = my_random_number
	print($BarrelTimer.wait_time)

