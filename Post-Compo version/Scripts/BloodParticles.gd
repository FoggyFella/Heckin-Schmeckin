extends CPUParticles2D

var start_to_dissapear = false

func _ready():
	$Timer.start(rand_range(0.15,0.35))

func _on_Timer_timeout():
	#set_process(false)
	set_physics_process(false)
	set_process_input(false)
	set_process_internal(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)
	$Timer2.start()

func _on_Timer2_timeout():
	start_to_dissapear = true

func _process(delta):
	if start_to_dissapear:
		modulate = lerp(modulate,Color(1,1,1,0),0.03)
	if modulate == Color(1,1,1,0):
		queue_free()
