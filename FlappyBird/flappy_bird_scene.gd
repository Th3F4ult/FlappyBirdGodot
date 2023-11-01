extends Node2D
func _ready():
	$PauseScreen.visible = false
	$MenuButton.visible = false
	$MenuButton/FINALPOINTS.add_theme_font_size_override("font_size", 96)
func PAUSEPRESS():
	$TextureButton.visible = not $TextureButton.visible
	get_tree().paused = not get_tree().paused
	$PauseScreen.visible = not $PauseScreen.visible
func _on_unpause_pressed():
	$TextureButton.visible = not $TextureButton.visible
	get_tree().paused = not get_tree().paused
	$PauseScreen.visible = not $PauseScreen.visible
func _on_retry_pressed():
	queue_free() 
	get_tree().change_scene_to_file("res://FlappyBird/flappy_bird_scene.tscn")
func _on_menu_pressed():
	get_tree().quit()
