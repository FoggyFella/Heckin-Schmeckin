extends Control

func _on_PlayButton_pressed():
	Transition.change_scene("res://Scenes/World.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_CreditsButton_pressed():
	Transition.change_scene("res://Scenes/Credits.tscn")
