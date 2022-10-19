extends Timer

var count = 0

func _on_Difficulty_Increase_Timer_timeout():
	if Global.spawn_time > 1:
		if count < 25:
			count += 1
		else:
			count = 0
		Global.spawn_time -= 0.025
	if count == 25:
		print("increasing health +10 and damage +5")
		Global.stats["enemy_damage"] += 5
		Global.stats["enemy_health"] += 10
