extends Node2D

class_name Pillars

signal gargoyle_entered
signal point_scored

var speed = 0

# used by spawner
func set_speed(new_speed):
	speed = new_speed
	
func _process(delta):
	position.x += speed * delta

func _on_body_entered(body):
	gargoyle_entered.emit()
	
func _on_point_scored(body):
	point_scored.emit()

# Pillars löschen wenn sie out of screen sind
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
