extends Node2D

var enemy = preload("res://Scenes/Enemy.tscn")

func _ready():
	$timer.start(Global.spawn_time + rand_range(-0.1,0.1))

func _on_timer_timeout():
	var enemy_inst = enemy.instance()
	enemy_inst.global_position = global_position
	enemy_inst.player = get_parent().get_node("Player")
	get_tree().root.add_child(enemy_inst)
	$timer.start(Global.spawn_time + rand_range(-0.1,0.1))
