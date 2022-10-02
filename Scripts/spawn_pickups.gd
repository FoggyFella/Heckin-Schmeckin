extends Node2D

var pick_up = preload("res://Scenes/pick_up.tscn")

func _on_PickupTimer_timeout():
	var spawn_location = Vector2(rand_range(-425,500),rand_range(240,-220))
	var pick_inst = pick_up.instance()
	pick_inst.message_label = $UI
	pick_inst.global_position = spawn_location
	get_tree().root.add_child(pick_inst)
