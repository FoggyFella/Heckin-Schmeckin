extends Node2D

var pick_up = preload("res://Scenes/pick_up.tscn")

func _on_PickupTimer_timeout():
	randomize()
	var point_i = int(rand_range(0,$PickUpSpawnLine.get_point_count()))
	var pick_inst = pick_up.instance()
	pick_inst.message_label = $UI
	pick_inst.global_position = $PickUpSpawnLine.get_point_position(point_i)
	get_tree().root.add_child(pick_inst)
