extends Node

@onready var gargoyle = $"../Gargoyle" as Gargoyle
@onready var pillar_spawner = $"../PillarSpawner" as PillarSpawner
@onready var ground = $"../Ground" as Ground
@onready var ui = $"../UI" as UI


var points = 0

func _ready():
	gargoyle.game_started.connect(on_game_started)
	ground.gargoyle_crashed.connect(end_game)
	pillar_spawner.gargoyle_crashed.connect(end_game)
	pillar_spawner.point_scored.connect(on_point_scored)

func on_game_started():
	pillar_spawner.start_spawning_pillars()

func end_game():
	ground.stop()
	gargoyle.kill()
	pillar_spawner.stop()
	ui.on_game_over()
	
func on_point_scored():
	points += 1
	ui.update_points(points)
