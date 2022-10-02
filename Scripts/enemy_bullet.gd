extends KinematicBody2D

export var bullet_speed : float = 3
export var damage: int = 20
var player = null
var lock_on = false
var direction_to_player = Vector2()
var velocity = Vector2.ZERO
var visible_really = false

func _ready():
	damage = Global.stats["enemy_damage"]

func _physics_process(delta):
	if !visible_really:
		queue_free()
	damage = Global.stats["enemy_damage"]
	if !lock_on:
		velocity += Vector2(bullet_speed*delta,0).rotated(rotation)
	else:
		velocity += Vector2(direction_to_player.normalized() * bullet_speed)# * delta)
	move_and_slide(velocity,Vector2.UP)
	for i in get_slide_count():
		queue_free()
		var collision = get_slide_collision(i)
		if collision.get_collider().has_method("take_damage"):
			collision.get_collider().take_damage(damage)


func _on_VisibilityNotifier2D_screen_exited():
	visible_really = false


func _on_VisibilityNotifier2D_screen_entered():
	visible_really = true
