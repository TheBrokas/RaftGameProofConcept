extends KinematicBody2D
var player
onready var use_state = false
onready var player_within_range = false
var Ball = load("res://Scenes/Structures/Ball.tscn")
var mouse_position

signal player_entered
signal player_exited

func _ready():
	var player_node = get_tree().get_root().find_node("Player",true,false)
	player_node.connect("state_is_move",self, "player_state_move")
	player_node.connect("state_is_use",self, "player_state_use")

func _physics_process(delta):
	mouse_position = get_local_mouse_position()
	if use_state == true && player_within_range == true:
		rotation += mouse_position.angle() * .1
	if Input.is_action_just_pressed("attack"):
		print("trying to shoot")
		shoot()

func shoot():
	if use_state == true && $AttackTimer.is_stopped():
		print("shot")
		$AttackTimer.start()
		var ball = Ball.instance()
		ball.position = $CannonPosition.global_position
		get_tree().current_scene.add_child(ball)
	else:
		pass

func player_state_use():
	use_state = true

func player_state_move():
	use_state = false

func _on_PlayerDetection_body_entered(body):
	print(body.name)
	if body.name == "Player":
		print(body.name)
		player_within_range = true
		emit_signal("player_entered")

func _on_PlayerDetection_body_exited(body):
	if body.name == "Player":
		player_within_range = false
		print(body.name)
		emit_signal("player_exited")
