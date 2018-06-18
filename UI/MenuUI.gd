extends CanvasLayer

#---------------------------------------------------
func _ready():
	show_menu(true)
	show_pause_menu(false)
	$MenuUI/VBoxContainer/StartButton.connect("button_down", self, "_handle_start_pressed")
	$MenuUI/VBoxContainer/ExitButton.connect("pressed", self, "_handle_exit_pressed")
	
	$IngameUI/IngamePauseMenu/VBoxContainer/ResumeButton.connect("pressed", self, "_handle_resume_pressed")
	$IngameUI/IngamePauseMenu/VBoxContainer/RestartButton.connect("pressed", self, "_handle_restart_pressed")
	$IngameUI/IngamePauseMenu/VBoxContainer/ExitButton.connect("pressed", self, "_handle_exit_pressed")
	
	GameManager.connect("on_paused", self, "_handle_on_paused")
	GameManager.connect("on_resumed", self, "_handle_on_resumed")
	
#---------------------------------------------------


#---------------------------------------------------

func show_menu(show):
	$MenuUI.visible = show

#---------------------------------------------------

func show_pause_menu(show):
	$IngameUI/IngamePauseMenu.visible = show

#---------------------------------------------------
	
func _handle_start_pressed():
	GameManager.start_gameplay()
	show_menu(false)

#---------------------------------------------------

func _handle_exit_pressed():
	get_tree().quit()

#---------------------------------------------------

func _handle_resume_pressed():
	if get_tree().paused:
		GameManager.toggle_pause()
	
#---------------------------------------------------
	
func _handle_restart_pressed():
	get_tree().reload_current_scene()
	
	if get_tree().paused:
		GameManager.toggle_pause()
	
#---------------------------------------------------	

func _handle_on_paused():
	show_pause_menu(true)

#---------------------------------------------------

func _handle_on_resumed():
	show_pause_menu(false)
		
#---------------------------------------------------

#func _process(delta):
#	pass
