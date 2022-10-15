extends KinematicBody2D

export var speed : float = 50.0
export var health : int = 100
onready var ui = $"../UI"
var velocity = Vector2.ZERO
onready var hurt = $hurt

func _physics_process(delta):
	speed = Global.stats["player_speed"]
	Global.stats["player_health"]
	health = Global.stats["player_health"]
	var movement_vector = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	var movement = movement_vector.normalized()
	
	if movement.x > 0:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true
	
	if movement == Vector2.ZERO:
		$AnimationPlayer.play("Idle")
	else:
		$AnimationPlayer.play("Walk")
	velocity = movement * speed
	move_and_slide(velocity,Vector2.UP)
	if Input.is_action_just_pressed("ui_up"):
		take_damage(1000)
func take_damage(amount):
	$Camera2D.NOISE_SHAKE_STRENGTH = rand_range(7,10)
	$Camera2D.apply_noise_shake()
	$hurt.play()
	var tween = create_tween()
	tween.parallel().tween_property($Sprite.get_material(),"shader_param/flash_modifier",1.0,0.05)
	tween.tween_property($Gun.get_material(),"shader_param/flash_modifier",1.0,0.05)
	tween.parallel().tween_property($Sprite.get_material(),"shader_param/flash_modifier",0.0,0.05)
	tween.tween_property($Gun.get_material(),"shader_param/flash_modifier",0.0,0.05)
	if Global.stats["player_health"] > 0 and Global.stats["player_health"]:
		Global.stats["player_health"] -= amount
		if Global.stats["player_health"] <= 0:
			Global.stats["player_health"] = 0
			yield(get_tree().create_timer(0.1),"timeout")
			ui.show_death_screen()
	elif Global.stats["player_health"] <= 0:
		Global.stats["player_health"] = 0
		yield(get_tree().create_timer(0.1),"timeout")
		ui.show_death_screen()
