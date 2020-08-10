extends KinematicBody2D

var velocity = Vector2()
const ACCELERATION = 2400
const MAX_SPEED = 100
const FRICTION = 2400
var smooth = 10
var movement_vector = Vector2.ZERO
var using_item = false
onready var next_to_item = false

signal state_is_use
signal state_is_move

enum {
	MOVE
	ATTACK
	USE
}

onready var state = MOVE

func move_state(delta):
	emit_signal("state_is_move")
	movement_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	movement_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	movement_vector = movement_vector.normalized()
	velocity = move_and_slide(velocity)
	if Input.is_action_pressed("down") or Input.is_action_pressed("up") or Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		#rotation = movement_vector.angle()
		var facing:float = atan2(movement_vector.y, movement_vector.x)
		rotation = lerp_angle(rotation, facing, smooth * delta)
	if movement_vector != Vector2.ZERO:
		velocity = velocity.move_toward(movement_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	if Input.is_action_just_pressed("Use"):
		print(next_to_item)
		if next_to_item == true: 
			print("Switching to use")
			state = USE
		else:
			pass
	#if Input.is_action_just_pressed("attack"):
		#state = ATTACK

func use_state():
	emit_signal("state_is_use")
	Vector2.ZERO
	if Input.is_action_just_pressed("Use"):
		state = MOVE



func attack_state():
	pass

func _ready():
	$Node2D/Promt.hide()
	next_to_item = false
	var cannon_node = get_tree().get_root().find_node("Cannon",true,false)
	cannon_node.connect("player_entered",self,"player_by_cannon")
	cannon_node.connect("player_exited",self,"player_not_by_cannon")

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state()
		USE:
			use_state()

func lerp_angle(from, to, weight):
	return from + short_angle_dist(from, to) * weight

func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference

func player_by_cannon():
	next_to_item = true
	$Node2D/Promt.show()

func player_not_by_cannon():
	next_to_item = false
	$Node2D/Promt.hide()
