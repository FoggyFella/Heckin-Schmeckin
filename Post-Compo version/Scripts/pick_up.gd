extends Area2D

var message_label = null
var key = 0
var pick_ups = {1:["player_damage",+30,"+30 damage for your gun!","green"],
2: ["enemy_damage", +15,"+15 damage to enemies!","red"],
3: ["player_health",+30,"+30 health for you!","green"],
4: ["enemy_health",+30,"+30 health for enemies!","red"],
5: ["player_damage", -10 ,"-10 damage for your gun!","red"],
6: ["enemy_health",-20,"-20 health to enemies!","green"],
7: ["player_damage", +20,"+20 damage to your gun!","green"],
8: ["player_speed", +20,"+20 speed to you!","green"],
9: ["player_speed", -20,"-20 speed for you!","red"],
10: ["enemy_speed", +10,"+10 speed to enemies","red"],
11: ["enemy_speed", -20,"-20 speed to enemies","green"],
12:["player_damage",+50,"+50 damage for your gun!","green"],
13: ["player_speed", +10,"+10 speed to you!","green"],
14: ["enemy_damage", -10,"-10 damage to enemies!","green"],
15: ["player_health",+50,"+50 heath for you!","green"],
16: ["player_health",+20,"+20 heath for you!","green"],
17: ["player_bullets",0,"+1 bullet to your gun!","green"],
18: ["player_bullets",0,"+1 bullet to your gun!","green"],
19: ["player_bullets",0,"+1 bullet to your gun!","green"],
20: ["player_bullets",0,"+1 bullet to your gun!","green"]
}

func _on_Pickup_body_entered(body):
	set_deferred("monitoring",false)
	Global.pick_ups += 1
	randomize()
	if Global.stats["player_bullets"].size() < 3:
		key = int(rand_range(1,20))
	else:
		key = int(rand_range(1,16))
	var color = null
	if "red" in pick_ups[key][3]:
		color = Color(0.78,0.12,0.27,1)
	else:
		color = Color(0.38,0.83,0.31,1)
	if key != 17 and key != 18 and key!= 19 and key!= 20:
		Global.stats[pick_ups[key][0]] += pick_ups[key][1]
	else:
		if Global.stats["player_bullets"].size() == 1:
			Global.stats["player_bullets"].append(0.2)
		elif Global.stats["player_bullets"].size() == 2:
			Global.stats["player_bullets"].append(-0.2)
	if message_label != null:
		message_label.message_popup(pick_ups[key][2],color)
	$picked_up.play()
	yield($picked_up,"finished")
	queue_free()


func _on_diss_timeout():
	queue_free()
