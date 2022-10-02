extends Sprite

var can_fire = true
var bullet = preload("res://Scenes/Bullet.tscn")
onready var gun_timeout = $"../gun timeout"

#func _ready():
	#top_level = true

func _physics_process(delta):
	var look_vec = get_global_mouse_position() - global_position
	rotation = atan2(look_vec.y,look_vec.x)
	
	if Input.is_action_pressed("fire"):
		fire()

func fire():
	if can_fire:
		$shoot.pitch_scale = rand_range(0.8,1)
		$shoot.play()
		var bullet_instance = bullet.instance()
		bullet_instance.global_rotation = global_rotation
		bullet_instance.global_position = $Position2D.global_position
		get_tree().root.add_child(bullet_instance)
		can_fire = false
		gun_timeout.start()



func _on_gun_timeout_timeout():
	can_fire = true
