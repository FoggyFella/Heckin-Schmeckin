extends Timer

func _on_Difficulty_Increase_Timer_timeout():
	print(Global.spawn_time)
	if Global.spawn_time > 1.5:
		Global.spawn_time -= 0.05
