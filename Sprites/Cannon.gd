extends KinematicBody2D
var player
onready var use_state = false
var Ball = load("res://Scenes/Ball.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("now_use_state", self, "player_state_use")

func _physics_process(delta):
	if Input.is_action_just_pressed("attack"):
		shoot()

func shoot():
	if use_state == true:
		var ball = Ball.instance()
		ball.position = $CannonPosition.global_position
		get_tree().current_scene.add_child(ball)
	else:
		pass

func player_state_use():
	use_state = true


#func player_state_move():
	#use_state = false

