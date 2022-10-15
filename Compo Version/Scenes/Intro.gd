extends ColorRect


func _ready():
	Textbox.queue_text("It was a fine saturday evening. As always our hero was smoking some weed, but then...    unspeakable happened")
	Textbox.queue_text("A DEVIL appeared in his room, offering him the worst deal imaginable: 'I will make you HIGH forever, but you will have to do my dirty work in HELL'")
	Textbox.queue_text("To which the hero replied: 'Yea dude, sure. Nice costume btw.'")
	Textbox.queue_text("'It's not a costume you bonehead'")
	Textbox.queue_text("So they shook their hands, and our hero began his journey.")

func _process(delta):
	if Textbox.text_queue == []:
		Transition.change_scene('res://Scenes/Menu.tscn')
		Music.playing = true
