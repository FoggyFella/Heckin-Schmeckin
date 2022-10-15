extends Area2D

var message_label = null

var pick_ups = {1:["player_damage",+30,"+30 damage for your gun!"],
2: ["enemy_damage", + 10,"+20 damage to your enemeies!"],
3: ["player_health",+30,"+30 health for you!"],
4: ["enemy_health",+30,"+30 health for your enemies!"],
5: ["player_damage", -10 ,"enemies took 10 damage from your gun!"],
6: ["enemy_health",-20,"-20 health to monsters!"],
7: ["player_damage", +10,"+10 damage to your gun!"],
8: ["player_speed", +20,"+20 speed to you!"],
9: ["player_speed", -20,"enemies took 20 speed from you!"],
10: ["enemy_speed", +10,"+10 speed to enemies"],
11: ["enemy_speed", -10,"-10 speed to monsters"]
}

func _on_Pickup_body_entered(body):
	set_deferred("monitoring",false)
	Global.pick_ups += 1
	var key = int(rand_range(1,11))
	var color = null
	if "enem" in pick_ups[key][2]:
		color = Color(0.78,0.12,0.27,1)
	else:
		color = Color(0.38,0.83,0.31,1)
	Global.stats[pick_ups[key][0]] += pick_ups[key][1]
	if message_label != null:
		message_label.message_popup(pick_ups[key][2],color)
	$picked_up.play()
	yield($picked_up,"finished")
	queue_free()


func _on_diss_timeout():
	queue_free()
