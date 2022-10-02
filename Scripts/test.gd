extends Line2D

var enemy = preload("res://Scenes/Enemy.tscn")

func _ready():
	$Timer.start(Global.spawn_time + rand_range(-0.1,0.1))



func _on_Timer_timeout():
	randomize()
	var point_i = int(rand_range(0,get_point_count()))
	var enemy_inst = enemy.instance()
	enemy_inst.global_position = get_point_position(point_i)
	enemy_inst.player = get_parent().get_node("Player")
	get_tree().root.add_child(enemy_inst)
	$Timer.start(Global.spawn_time + rand_range(-0.1,0.1))

