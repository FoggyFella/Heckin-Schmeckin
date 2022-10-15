extends CanvasLayer

func message_popup(text,color):
	var tween = create_tween()
	$Label.text = str(text)
	$Label.modulate = color
	tween.tween_property($Label,"rect_position",Vector2($Label.rect_position.x,551),0.3)
	yield(get_tree().create_timer(2),"timeout")
	var tween2 = create_tween()
	tween2.tween_property($Label,"rect_position",Vector2($Label.rect_position.x,618),0.2)

func _process(delta):
	$Label2.text = "Health: " + str(Global.stats["player_health"])

func show_death_screen():
	for c in get_tree().root.get_children():
		if c.is_in_group("enemy_group"):
				c.player = null
		elif c.is_in_group("pick_up_group"):
			c.message_label = null
	get_tree().paused = true
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	$DeathScreen/VBoxContainer/Label2.text = "You collected "+ str(Global.pick_ups) + " pick-ups"
	$DeathScreen/VBoxContainer/Label3.text = "You killed "+ str(Global.enemies_killed) + " enemies"
	tween.tween_property($DeathScreen,"rect_position",Vector2($DeathScreen.rect_position.x,0),1)


func _on_Button_pressed():
	for c in get_tree().root.get_children():
		if c.is_in_group("enemy_group") or c.is_in_group("enemy_bullets") or c.is_in_group("pick_up_group"):
			c.queue_free()
	Global.reset_stats()
	Transition.reload_current_scene()
