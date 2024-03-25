extends Node

class_name PillarSpawner

signal gargoyle_crashed
signal point_scored

var pillars_scene = preload("res://Scenes/pillars.tscn")



# pillar speed = ground speed
@export var pillar_speed = -70

@onready var spawn_timer = $SpawnTimer

func _ready():
	spawn_timer.start()

func start_spawning_pillars():
	spawn_timer.timeout.connect(spawn_pillars)

func spawn_pillars():
	var pillar = pillars_scene.instantiate() as Pillars
	add_child(pillar)
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	pillar.position.x = viewport_rect.end.x
	
	var half_height = viewport_rect.size.y / 2
	pillar.position.y = randf_range(viewport_rect.size.y * 0.15 - half_height, viewport_rect.size.y * 0.65 - half_height)
	
	pillar.gargoyle_entered.connect(on_gargoyle_entered)
	pillar.point_scored.connect(on_point_scored)
	pillar.set_speed(pillar_speed)
	
func on_gargoyle_entered():
	gargoyle_crashed.emit()
	stop()
		
func stop():
	spawn_timer.stop()
	for pillar in get_children().filter(func (child): return child is Pillars):
		(pillar as Pillars).speed = 0
		
func on_point_scored():
	point_scored.emit()

