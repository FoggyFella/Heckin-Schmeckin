extends Sprite

var can_fire = true
var bullet = preload("res://Scenes/Bullet.tscn")
onready var gun_timeout = $"../gun timeout"
var rots = [0]
var look_vec = null
var firerate = 0.35
onready var camera = $"../Camera2D"

func _ready():
	Global.connect("pick_up_collected",self,"update_self_stats")

func _physics_process(delta):
	look_vec = get_global_mouse_position() - global_position
	rotation = atan2(look_vec.y,look_vec.x)
	
	if abs(rotation_degrees) > 88:
		scale.y = lerp(scale.y,-1,0.1)
		#scale.y = -1
	else:
		scale.y = lerp(scale.y,1,0.1)
	
	if Input.is_action_pressed("fire"):
		fire()

func fire():
	if can_fire:
		can_fire = false
		$AnimationPlayer.play("Shoot")
		randomize()
		var random_numbah = int(rand_range(1,2))
		camera.RANDOM_SHAKE_STRENGTH = 2.5
		camera.apply_random_shake()
		rots = Global.stats["player_bullets"]
		get_node("shoot" + str(random_numbah)).pitch_scale = rand_range(0.85,1.3)
		get_node("shoot" + str(random_numbah)).play()
		for i in range(rots.size()):
			var bullet_instance = bullet.instance()
			bullet_instance.global_rotation = global_rotation + rots[i]
			bullet_instance.global_position = $Position2D.global_position
			get_tree().root.add_child(bullet_instance)
			gun_timeout.start(firerate)

func update_self_stats():
	firerate = Global.stats["player_firerate"]

func _on_gun_timeout_timeout():
	can_fire = true
