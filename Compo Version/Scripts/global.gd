extends Node

var pick_ups = 0
var enemies_killed = 0
var spawn_time = 3
var player_damage = 50
var enemy_damage = 20

var stats = {"player_damage":50,
"enemy_damage": 10,
"enemy_health": 100,
"player_health": 100,
"player_speed":150,
"enemy_speed": 80}

func reset_stats():
	stats["player_damage"]=50
	stats["enemy_damage"]=10
	stats["enemy_health"]=100
	stats["player_health"]=100
	stats["player_speed"]=150
	stats["enemy_speed"]=80
	print(stats)
