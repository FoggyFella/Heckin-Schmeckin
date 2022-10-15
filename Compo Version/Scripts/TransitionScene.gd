extends CanvasLayer

func reload_current_scene():
	$AnimationPlayer.play("transition_bar")
	yield($AnimationPlayer,"animation_finished")
	get_tree().reload_current_scene()
	if get_tree().paused:
		get_tree().paused = false
	$AnimationPlayer.play_backwards("transition_bar")

func change_scene(target):
	$AnimationPlayer.play("transition_2")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene(target)
	$AnimationPlayer.play_backwards("transition_2")
