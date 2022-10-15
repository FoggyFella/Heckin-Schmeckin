extends KinematicBody2D

export var damage : int = 50
export var bullet_speed : float = 50
onready var timer_to_dissapear = $timer_to_dissapear
var lock_on = false
var velocity = Vector2.ZERO

func _ready():
	damage = Global.stats["player_damage"]
func _physics_process(delta):
	#damage = Global.stats["player_damagey"]
	velocity += Vector2(bullet_speed*delta,0).rotated(rotation) 
	var info = move_and_collide(velocity)
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		if collision.get_collider().has_method("take_damage"):
#			queue_free()
#			collision.get_collider().take_damage(damage)
	if info != null:
		if info.collider.has_method("take_damage"):
			queue_free()
			if !info.collider.stun:
				info.collider.take_damage(damage)
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	$timer_to_dissapear.start()


func _on_timer_to_dissapear_timeout():
	queue_free()
