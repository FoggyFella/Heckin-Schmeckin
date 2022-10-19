extends ColorRect

var should_play = true

func _ready():
	Textbox.queue_text("It was a fine saturday evening. As always our hero was smoking some weed, but then...    unspeakable happened")
	Textbox.queue_text("A DEVIL appeared in his room, offering him the worst deal imaginable: 'I will make you HIGH forever, but you will have to TRAIN my DEMONS in the UNDERWORLD'")
	Textbox.queue_text("'And you will do that by shooting them with this gun, here have it.'")
	Textbox.queue_text("'DO YOU ACCEPT THE OFFER?'")
	Textbox.queue_text("The hero replied: 'Yea dude, sure. Nice costume btw.'")
	Textbox.queue_text("'It's not a costume you bonehead'")
	Textbox.queue_text("So they shook their hands, and our hero began his journey.")

func _process(delta):
	if Textbox.text_queue == [] and should_play:
		should_play = false
		var tween = create_tween()
		tween.tween_property($"intro music","volume_db",-60.0,3)
		yield(tween,"finished")
		Transition.change_scene('res://Scenes/Menu.tscn')
		Music.fade_in(3)
