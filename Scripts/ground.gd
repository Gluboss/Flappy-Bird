extends Node2D

class_name Ground

signal gargoyle_crashed

@export var speed = -70

@onready var sprite1 = $Ground_1/Sprite2D
@onready var sprite2 = $Ground_2/Sprite2D


func _ready():
	sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()

func _process(delta):
	sprite1.global_position.x += speed * delta
	sprite2.global_position.x += speed * delta

	# if sprite1 completely leaves the screen move it to the right of sprite2
	if sprite1.global_position.x < -sprite1.texture.get_width():
		sprite1.global_position.x = sprite2.global_position.x + sprite2.texture.get_width()

	# if sprite2 completely leaves the screen move it to the right of sprite1
	if sprite2.global_position.x < -sprite2.texture.get_width():
		sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()


func _on_body_entered(body):
	gargoyle_crashed.emit()
	stop()
	(body as Gargoyle).stop()
	
func stop():
	speed = 0
