extends AudioStreamPlayer


func fade_in(time):
	playing = true
	var tween = create_tween()
	tween.tween_property(self,"volume_db",-10.0,time)
