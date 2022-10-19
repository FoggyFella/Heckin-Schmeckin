extends Node

signal pick_up_collected

var player = null

var player_max_health = 100
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
"player_bullets": [0],
"player_firerate" : 0.35}

var time = 0
var timer_on = false
var time_text = null

func _ready():
#here you should configure the silentwolf with your api key and game id
#i didn't include my keys for security reasons
	SilentWolf.configure({
		"api_key": "APIKEY",
		"game_id": "GAMEID",
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
	stats["player_firerate"] = 0.35
	player_max_health = 100
	score = 0
	print(stats)

func _process(delta):
	if stats["enemy_damage"] < 10:
		stats["enemy_damage"] = 10
	if stats["enemy_speed"] < 40:
		stats["enemy_speed"] = 40
	if stats["enemy_health"] < 20:
		stats["enemy_health"] = 20
	if timer_on:
		time += delta
	
	var secs = fmod(time,60)
	var mins = fmod(time, 60*60) / 60
	
	var time_passed = "%02d : %02d" % [mins,secs]
	time_text = time_passed

func reset_timer():
	time = 0
func start_timer():
	timer_on = true
func stop_timer():
	timer_on = false
