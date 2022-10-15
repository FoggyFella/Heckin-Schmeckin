extends CanvasLayer

const character_read_rate = 0.1

onready var textbox_container = $TextContainer
onready var start_symbol = $TextContainer/MarginContainer/HBoxContainer/Start
onready var end_symbol = $TextContainer/MarginContainer/HBoxContainer/End
onready var label = $TextContainer/MarginContainer/HBoxContainer/Label2

enum State{
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

func _ready():
	hide_textbox()
	
func _process(delta):
	
	match current_state:
		State.READY:
			
			if !text_queue.empty():
				display_text()
				get_tree().paused = true
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.percent_visible = 1.0
				$Tween.remove_all()
				end_symbol.text = 'v'
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_textbox()

func queue_text(next_text):
	text_queue.push_back(next_text)
	

func hide_textbox():
	get_tree().paused = false
	start_symbol.text = ''
	end_symbol.text = ""
	label.text = ''
	textbox_container.hide()

func show_textbox():
	start_symbol.text = '*'
	textbox_container.show()
	
func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	label.percent_visible = 0.0
	change_state(State.READING)
	show_textbox()
	$Tween.interpolate_property(label, "percent_visible" , 0.0,1.0, len(next_text) * character_read_rate, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()

	
func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to state.READY")
		State.READING:
			print("Changing state to state.READING")
		State.FINISHED:
			print("Changing state to state.FINISHED")


func _on_Tween_tween_completed(object, key):
		end_symbol.text = "v"
		change_state(State.FINISHED)
