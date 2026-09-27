extends AnimatedSprite2D

var dragging = false
var mouse_over_goku = false
var drag_offset = Vector2.ZERO

var current_state = "IDLE"

var last_typing_time = 0.0
var typing_timeout = 0.5
var last_alt_time = 0.0
var alt_double_tap_time = 0.4

func _ready():
	set_state("IDLE")

func switch_animation(animation_name):
	if animation != animation_name:
		play(animation_name)
		
func set_state(new_state):
	current_state = new_state

	match current_state:
		"IDLE":
			switch_animation("default")

		"PUNCH":
			switch_animation("Punch")

		"KAMEHAMEHA":
			switch_animation("KAMEHAMEHA")

func _input(event):

	if event is InputEventKey and event.pressed:
		if event.keycode >= KEY_A and event.keycode <= KEY_Z:
			last_typing_time = Time.get_ticks_msec() / 1000.0
			set_state("PUNCH")

		elif event.keycode >= KEY_0 and event.keycode <= KEY_9:
			last_typing_time = Time.get_ticks_msec() / 1000.0
			set_state("PUNCH")

		elif event.keycode == KEY_SPACE:
			last_typing_time = Time.get_ticks_msec() / 1000.0
			set_state("PUNCH")

		elif event.keycode == KEY_BACKSPACE:
			last_typing_time = Time.get_ticks_msec() / 1000.0
			set_state("PUNCH")

		elif event.keycode == KEY_ENTER:
			last_typing_time = Time.get_ticks_msec() / 1000.0
			set_state("PUNCH")
			
		elif event.keycode == KEY_ALT:
			var current_time = Time.get_ticks_msec() / 1000.0

			if current_time - last_alt_time < alt_double_tap_time:
				set_state("KAMEHAMEHA")

			last_alt_time = current_time


	if event is InputEventMouseButton:

		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			last_typing_time = Time.get_ticks_msec() / 1000.0
			set_state("PUNCH")

		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			set_state("KAMEHAMEHA")

		if event.pressed and mouse_over_goku:
			dragging = true
		elif not event.pressed:
			dragging = false
			
func _process(delta):
	if dragging:
		global_position = get_global_mouse_position()

	if current_state == "PUNCH":
		if Time.get_ticks_msec() / 1000.0 - last_typing_time > typing_timeout:
			set_state("IDLE")

func _on_area_2d_mouse_entered() -> void:
	mouse_over_goku = true

func _on_area_2d_mouse_exited() -> void:
	mouse_over_goku = false


func _on_animation_finished() -> void:
	set_state("IDLE")
