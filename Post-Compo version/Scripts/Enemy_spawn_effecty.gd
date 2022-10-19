extends Node2D

var enemy = null

func _on_AnimationTimer_timeout():
	var enemy_inst = enemy.instance()
	enemy_inst.global_position = self.position
	#enemy_inst.player = get_parent().get_node("Player")
	get_tree().root.add_child(enemy_inst)

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
