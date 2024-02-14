extends Node2D

signal enemy_spawned(enemy_instace)
signal path_enemy_spawned(enemy_spawn)

var enemy_scene = preload("res://scenes/enemy.tscn")
var path_enemy_scene = preload("res://scenes/path_enemy.tscn")

@onready var spawn_positions = $SpawnPositions

func _on_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var spawn_position = spawn_positions.get_children()
	var random_position = spawn_position.pick_random()
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position= random_position.global_position
	emit_signal("enemy_spawned", enemy_instance)

func _on_path_enemy_timeout():
	spawn_path_enemy()

func spawn_path_enemy():
	var path_enemy_instance = path_enemy_scene.instantiate()
	emit_signal("path_enemy_spawned", path_enemy_instance)
