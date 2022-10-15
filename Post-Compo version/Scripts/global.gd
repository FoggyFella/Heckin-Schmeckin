extends Node

var pick_ups = 0
var enemies_killed = 0
var spawn_time = 3
var player_damage = 50
var enemy_damage = 20
var score = 0

var stats = {"player_damage":50,
"enemy_damage": 10,
"enemy_health": 100,
"player_health": 100,
"player_speed":150,
"enemy_speed": 80,
"player_bullets": [0]}

func _ready():
#here I configure the SilentWolf addon for leaderboard to work
#I did not include my api_key and stuff for security reasons
	SilentWolf.configure({
		"api_key": "api_key_here",
		"game_id": "game_id_here",
		"game_version": "1.0",
		"log_level": 0
	})

func reset_stats():
	pick_ups = 0
	enemies_killed = 0
	spawn_time = 3
	stats["player_damage"]=50
	stats["enemy_damage"]=10
	stats["enemy_health"]=100
	stats["player_health"]=100
	stats["player_speed"]=150
	stats["enemy_speed"]=80
	stats["player_bullets"]=[0]
	score = 0
	print(stats)

func _process(delta):
	if stats["enemy_damage"] < 10:
		stats["enemy_damage"] = 10
	if stats["enemy_speed"] < 40:
		stats["enemy_speed"] = 40
	if stats["enemy_health"] < 20:
		stats["enemy_health"] = 20
