extends Area2D

var message_label = null
var key = 0
var pick_ups = {
1: ["player_bullets",0,"+1 bullet to your gun!","green"],
2: ["player_bullets",0,"+1 bullet to your gun!","green"],
3: ["player_bullets",0,"+1 bullet to your gun!","green"],
4: ["player_bullets",0,"+1 bullet to your gun!","green"],
5:["player_damage",+30,"+30 damage for your gun!","green"],
6: ["enemy_damage", +15,"+15 damage to your enemies!","red"],
7: ["player_health",+30,"+30 health for you!","green"],
8: ["enemy_health",+30,"+30 health for your enemies!","red"],
9: ["player_damage", -10 ,"-10 damage for your gun!","red"],
10: ["enemy_health",-20,"-20 health to your enemies!","green"],
11: ["player_damage", +20,"+20 damage to your gun!","green"],
12: ["player_speed", +20,"+20 speed to you!","green"],
13: ["player_speed", -20,"-20 speed for you!","red"],
14: ["enemy_speed", +10,"+10 speed to your enemies","red"],
15: ["enemy_speed", -20,"-20 speed to your enemies","green"],
16:["player_damage",+50,"+50 damage for your gun!","green"],
17: ["player_speed", +10,"+10 speed to you!","green"],
18: ["enemy_damage", -10,"-10 damage to your enemies!","green"],
19: ["player_health",+50,"+50 health for you!","green"],
20: ["player_health",+20,"+20 health for you!","green"],
21: ["player_firerate",-0.025,"+0.025 firerate for your gun!","green"]
}

func _on_Pickup_body_entered(body):
	set_deferred("monitoring",false)
	Global.pick_ups += 1
	randomize()
	if Global.stats["player_bullets"].size() < 3:
		key = int(rand_range(1,21))
	else:
		key = int(rand_range(5,21))
	var color = null
	if "red" in pick_ups[key][3]:
		color = Color(0.78,0.12,0.27,1)
	else:
		color = Color(0.38,0.83,0.31,1)
	if key != 1 and key != 2 and key!= 3 and key!= 4:
		Global.stats[pick_ups[key][0]] += pick_ups[key][1]
	else:
		if Global.stats["player_bullets"].size() == 1:
			Global.stats["player_bullets"].append(0.2)
		elif Global.stats["player_bullets"].size() == 2:
			Global.stats["player_bullets"].append(-0.2)
	Global.emit_signal("pick_up_collected")
	if message_label != null:
		message_label.message_popup(pick_ups[key][2],color)
	$picked_up.play()
	yield($picked_up,"finished")
	queue_free()


func _on_diss_timeout():
	queue_free()
