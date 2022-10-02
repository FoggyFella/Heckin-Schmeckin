extends KinematicBody2D

var speed : float = 50
export var damage : int = 30
export var health : int = 100
export var min_speed : float = 50
export var max_speed : float = 85
export var min_wait : float = 2
export var max_wait : float = 4

var can_shoot = true
var bullet = preload("res://Scenes/enemy_bullet.tscn")
var direction_to_player = Vector2()
var player = null
var velocity = Vector2.ZERO

func _ready():
	health = Global.stats["enemy_health"]
	scale.x = rand_range(0.8,1)
	scale.y = scale.x
	speed = Global.stats["enemy_speed"] - rand_range(0,20)

func _physics_process(delta):
	if player != null:
		direction_to_player = Vector2(player.global_position - global_position)
		velocity = direction_to_player.normalized() * speed
		move_and_slide(velocity,Vector2.UP)
		if can_shoot:
			shoot()

func shoot():
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
	#bullet_inst.look_at(player.global_position)

func take_damage(how_much):
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
			$death.pitch_scale = rand_range(0.8,1)
			$death.play()
			yield(tween,"finished")
			queue_free()
			Global.enemies_killed += 1
	elif health <= 0:
		health = 0
		$death.pitch_scale = rand_range(0.8,1)
		$death.play()
		yield(tween,"finished")
		queue_free()
		Global.enemies_killed += 1
	yield(tween,"finished")
	$reload.start(rand_range(min_wait - 1,max_wait - 1))


func _on_reload_timeout():
	can_shoot = true
