extends CharacterBody2D

signal took_damage

const SPEED = 300.0

@onready var rocket = preload("res://scenes/rocket.tscn")
@onready var rocket_container = $RocketContainer
@onready var laser = $Laser

func _ready():
	$Flame.emitting = true

func _process(delta):
	_fire()

func _physics_process(delta):
	_update_user_velocity()
	move_and_slide()
	_clamping_user_position()

func _update_user_velocity():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity = Vector2(0, -SPEED)
	if Input.is_action_pressed("move_down"):
		velocity = Vector2(0, SPEED)
	if Input.is_action_pressed("move_left"):
		velocity = Vector2(-SPEED, 0)
	if Input.is_action_pressed("move_right"):
		velocity = Vector2(SPEED, 0)

func _clamping_user_position():
	var screen_size =  get_viewport_rect().size
	global_position = global_position.clamp(Vector2(0, 0), screen_size)


func _fire():
	if Input.is_action_just_pressed("fire"):
		var rocket_instance = rocket.instantiate()
		rocket_container.add_child(rocket_instance)
		rocket_instance.global_position = global_position
		rocket_instance.global_position.x += 80
		laser.play()

func die():
	queue_free()

func take_damage():
	emit_signal("took_damage")
