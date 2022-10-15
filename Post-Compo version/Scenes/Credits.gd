extends ColorRect

var colora = Color()

func _ready():
	colora = Color(rand_range(0,1),rand_range(0,1),rand_range(0,1),1)

func _process(delta):
	color = lerp(color,colora,0.01)


func _on_Timer_timeout():
	colora = Color(rand_range(0,1),rand_range(0,1),rand_range(0,1),1)


func _on_Button_pressed():
	Transition.change_scene("res://Scenes/Menu.tscn")
