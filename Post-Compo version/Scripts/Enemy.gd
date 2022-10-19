extends KinematicBody2D

var speed : float = 50
export var damage : int = 30
export var health : int = 100
export var min_speed : float = 50
export var max_speed : float = 85
export var min_wait : float = 2
export var max_wait : float = 4
export var bite_damage : int = 5

var stun = false
var can_shoot = true
var direction_to_player = Vector2()
var player = null
var is_visisble = false
var velocity = Vector2.ZERO
var can_bite = true

var number_of_damage = preload("res://Scenes/NumberPopup.tscn")
var bullet = preload("res://Scenes/enemy_bullet.tscn")
var blood = preload("res://Scenes/BloodParticles.tscn")
var sprite_size_x = null

func _ready():
	sprite_size_x = $Sprite.scale.x
	$HealthBar.max_value = health
	$HealthBar.value = health
	health = Global.stats["enemy_health"]
	scale.x = rand_range(0.8,1)
	scale.y = scale.x
	speed = Global.stats["enemy_speed"] - rand_range(0,20)
	player = Global.player

func _physics_process(delta):
	var overlapping_bodies = $Hitbox.get_overlapping_bodies()
	for i in overlapping_bodies:
		if stun == false:
			take_damage(i.damage)
			i.queue_free()
	if player != null and stun == false:
		direction_to_player = Vector2(player.global_position - global_position)
		velocity = direction_to_player.normalized() * speed
		move_and_slide(velocity,Vector2.UP)
		if direction_to_player.x < 0:
			$Sprite.scale.x = lerp($Sprite.scale.x,-sprite_size_x,0.27)
		else:
			$Sprite.scale.x = lerp($Sprite.scale.x,sprite_size_x,0.27)
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.get_collider().has_method("take_damage") and collision.get_collider().name == "Player":
				if can_bite:
					can_bite = false
					$bite_timer.start()
					collision.get_collider().take_damage(bite_damage)
		if can_shoot and is_visisble:
			shoot()

func shoot():
	if $timer2.is_stopped():
		$AnimationPlayer.play("shoot")
		$timer2.start()
#	$shoot.pitch_scale = rand_range(0.7,0.9)
#	$shoot.play()
#	can_shoot = false
#	$reload.start(rand_range(min_wait,max_wait))
#	var bullet_inst = bullet.instance()
#	bullet_inst.global_position = $Position2D.global_position
#	get_tree().root.add_child(bullet_inst)
#	bullet_inst.player = player
#	bullet_inst.damage = damage
#	bullet_inst.direction_to_player = direction_to_player
#	bullet_inst.lock_on = true
	#bullet_inst.look_at(player.global_position)

func take_damage(how_much):
	update_health_bar(how_much)
	if $HealthBar.value > 0:
		show_health_bar()
	var numb_inst = number_of_damage.instance()
	numb_inst.amount = how_much
	numb_inst.type == "Red"
	numb_inst.position = self.position
	get_tree().root.add_child(numb_inst)
	randomize()
	stun = true
	velocity = -velocity * 10
	move_and_slide(velocity,Vector2.UP)
	health -= how_much
	can_shoot = false
	var tween = create_tween()
	tween.tween_property($Sprite.get_material(),"shader_param/flash_modifier",1.0,0.05)
	tween.tween_property($Sprite.get_material(),"shader_param/flash_modifier",0.0,0.05)
	if health > 0:
		$hurt.pitch_scale = rand_range(0.8,1)
		$hurt.play()
		#health -= how_much
		if health <=0:
			var blood_inst = blood.instance()
			blood_inst.global_position = global_position
			blood_inst.rotation = global_position.angle_to_point(player.global_position)
			get_tree().root.add_child(blood_inst)
			$death.pitch_scale = rand_range(0.8,1)
			$death.play()
			yield(tween,"finished")
			queue_free()
			Global.enemies_killed += 1
	elif health <= 0:
		var blood_inst = blood.instance()
		blood_inst.global_position = global_position
		blood_inst.rotation = global_position.angle_to_point(player.global_position)
		get_tree().root.add_child(blood_inst)
		health = 0
		$death.pitch_scale = rand_range(0.8,1)
		$death.play()
		yield(tween,"finished")
		queue_free()
		Global.enemies_killed += 1
	yield(tween,"finished")
	stun = false
	direction_to_player = Vector2(player.global_position - global_position)
	velocity = direction_to_player.normalized() * speed
	$reload.start(rand_range(min_wait - 1,max_wait - 1))


func _on_reload_timeout():
	can_shoot = true


func _on_VisibilityNotifier2D_screen_exited():
	is_visisble = false


func _on_VisibilityNotifier2D_screen_entered():
	is_visisble = true


func _on_timer2_timeout():
	$shoot.pitch_scale = rand_range(0.7,0.9)
	$shoot.play()
	can_shoot = false
	$reload.start(rand_range(min_wait,max_wait))
	var bullet_inst = bullet.instance()
	bullet_inst.global_position = $Position2D.global_position
	get_tree().root.add_child(bullet_inst)
	bullet_inst.player = player
	bullet_inst.damage = damage
	bullet_inst.direction_to_player = direction_to_player
	bullet_inst.lock_on = true

func show_health_bar():
	if $HealthBar.visible == false:
		$HealthBar.visible = true

func update_health_bar(amount_of_damage):
	$HealthBar.value = health - amount_of_damage


func _on_bite_timer_timeout():
	can_bite = true
