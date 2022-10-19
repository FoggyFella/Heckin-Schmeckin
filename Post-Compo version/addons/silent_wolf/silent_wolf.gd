tool
extends EditorPlugin

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS 

func _enter_tree():
	add_autoload_singleton("SilentWolf", "res://addons/silent_wolf/SilentWolf.gd")

func _exit_tree():
	remove_autoload_singleton("SilentWolf")
