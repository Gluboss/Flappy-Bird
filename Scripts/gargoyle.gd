extends CharacterBody2D

class_name Gargoyle

signal game_started

@export var gravity = 900.0
@export var jump_force = -250
@export var rotation_speed = 2

@onready var animation_player = $AnimationPlayer

var max_speed = 400
var is_started = false
# var for stopping input after Gargoyle crashes
var process_input = true

func _ready():
	velocity = Vector2.ZERO
	animation_player.play("Idle")

func _physics_process(delta):
	if Input.is_action_just_pressed("jump") && process_input:
		if !is_started:
			game_started.emit()
			animation_player.play("FlapFlap")
			is_started = true
		jump()

	if !is_started:
		return
	velocity.y += gravity * delta
	
	# Beschleunigung bei Runterfallen = max Speed
	if velocity.y > max_speed:
		velocity.y = max_speed

	move_and_collide(velocity * delta)

	rotate_gargoyle()

func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-30)


func rotate_gargoyle():
	# rotate Gargoyle when falling (Nosedive)
	if velocity.y > 0 and rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)

	# rotate Gargoyle when rising (Nose up)
	elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		rotation -=rotation_speed * deg_to_rad(1)

func kill():
	process_input = false

func stop():
	animation_player.stop()
	gravity = 0 
	velocity = Vector2.ZERO
	
