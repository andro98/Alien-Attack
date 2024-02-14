extends Node2D

var health = 3
var score = 0

@onready var player = $Player
@onready var enemySpwaner = $EnemySpawner
@onready var hud = $UI/HUD
@onready var ui = $UI

@onready var enemy_hit_sound = $EnemyHitSound
@onready var explode = $Explode

var gos_scene = preload("res://scenes/game_over_screen.tscn")

func _ready():
	hud.set_score_label(score)
	hud.set_health_label(health)

func _on_death_zone_area_entered(area):
	area.queue_free()

func game_over():
	player.die()
	
	await get_tree().create_timer(1.5).timeout
	
	var gos = gos_scene.instantiate()
	gos.set_score(score)
	ui.add_child(gos)

func _on_player_took_damage():
	health -= 1
	hud.set_health_label(health)
	if health <= 0:
		game_over()
	explode.play()

func _on_enemy_spawner_enemy_spawned(enemy_instace):
	enemySpwaner.add_child(enemy_instace)
	enemy_instace.connect("died", _on_enemy_died)

func _on_enemy_died():
	score += 50
	hud.set_score_label(score)
	enemy_hit_sound.play()


func _on_enemy_spawner_path_enemy_spawned(enemy_spawn):
	add_child(enemy_spawn)
	enemy_spawn.enemy.connect("died", _on_enemy_died)
