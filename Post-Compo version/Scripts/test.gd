extends Line2D

var enemy = preload("res://Scenes/Enemy.tscn")
var enemy_spawn_effect = preload("res://Scenes/Enemy_spawn_effecty.tscn")
var point_i = int(rand_range(0,get_point_count()))

func _ready():
	$Timer.start(Global.spawn_time)

func _on_Timer_timeout():
	yield(get_tree().create_timer(1),"timeout")
	randomize()
	point_i = int(rand_range(0,get_point_count()))
	var enemy_spawn = enemy_spawn_effect.instance()
	enemy_spawn.position = get_point_position(point_i)
	enemy_spawn.enemy = enemy
	get_tree().root.add_child(enemy_spawn)
	$Timer.start(Global.spawn_time)
