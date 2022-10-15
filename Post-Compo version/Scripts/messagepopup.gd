extends CanvasLayer

onready var pickup_timer = $"../PickupTimer"
var namey = ""
var ld_name = "main"
var can_submit = true
var allowed_characters = "[A-Za-z-_]"

func _ready():
	$DeathScreen.rect_position = Vector2(0,800)

func message_popup(text,color):
	var tween = create_tween()
	$Label.text = str(text)
	$Label.modulate = color
	tween.tween_property($Label,"rect_position",Vector2($Label.rect_position.x,551),0.3)
	yield(get_tree().create_timer(2),"timeout")
	var tween2 = create_tween()
	tween2.tween_property($Label,"rect_position",Vector2($Label.rect_position.x,618),0.2)

func _process(delta):
	$TextureProgress.value = lerp($TextureProgress.value,pickup_timer.time_left,0.1)
	$Label2.text = "Health: " + str(Global.stats["player_health"])

func show_death_screen():
	var score_here = Global.enemies_killed + Global.pick_ups
	Global.score = score_here
	for c in get_tree().root.get_children():
		if c.is_in_group("enemy_group"):
				c.player = null
		elif c.is_in_group("pick_up_group"):
			c.message_label = null
	get_tree().paused = true
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	$DeathScreen/VBoxContainer/Label2.text = "You collected: "+ str(Global.pick_ups) + " pick-ups"
	$DeathScreen/VBoxContainer/Label3.text = "You killed: "+ str(Global.enemies_killed) + " enemies"
	$DeathScreen/VBoxContainer/Label4.text = "Score: "+ str(Global.score)
	tween.tween_property($DeathScreen,"rect_position",Vector2(0,0),1)


func _on_Button_pressed():
	for c in get_tree().root.get_children():
		if c.is_in_group("enemy_group") or c.is_in_group("enemy_bullets") or c.is_in_group("pick_up_group"):
			c.queue_free()
	Global.reset_stats()
	Transition.reload_current_scene()


func _on_ShowLB_pressed():
	$DeathScreen/Leaderboard.visible = true


func _on_SubmitScore_pressed():
	$DeathScreen/SubmitScorePanel.visible = true


func _on_LineEdit_text_changed(new_text):
	var old_caret_position = $DeathScreen/SubmitScorePanel/LineEdit.caret_position
	var word = ''
	var regex = RegEx.new()
	regex.compile(allowed_characters)
	for valid_character in regex.search_all(new_text):
		word += valid_character.get_string()
	$DeathScreen/SubmitScorePanel/LineEdit.set_text(word)
	$DeathScreen/SubmitScorePanel/LineEdit.caret_position = old_caret_position
	namey = str($DeathScreen/SubmitScorePanel/LineEdit.text)
	print(namey)

func _on_LineEdit_text_entered(new_text):
	namey = str(new_text)
	print(namey)

func _on_ActualSubmitScore_pressed():
	if namey != "" and can_submit:
		can_submit = false
		SilentWolf.Scores.persist_score(str(namey),Global.score)
		$DeathScreen/SubmitScorePanel.visible = false
	elif namey == "":
		var tween = create_tween().set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
		tween.tween_property($DeathScreen/SubmitScorePanel/VBoxContainer/Label5,"modulate",Color(1,1,1,1),0.3)
		tween.tween_interval(2)
		tween.tween_property($DeathScreen/SubmitScorePanel/VBoxContainer/Label5,"modulate",Color(1,1,1,0),0.3)
