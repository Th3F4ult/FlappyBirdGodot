extends Node2D


func _ready():
	$PauseScreen.visible = false
	$MenuButton.visible = false
	$MenuButton/FINALPOINTS.add_theme_font_size_override("font_size", 96)

func _process(delta):
	if Global.mode == "night":
		$ParallaxBackground/ParallaxLayer/TextureRect.texture = load("res://FlappyBird/assets/Other_Stuff_Images/PARBACKGRNG.png")
	else:
		$ParallaxBackground/ParallaxLayer/TextureRect.texture = load("res://FlappyBird/assets/Other_Stuff_Images/PARBACKGRNGDAY.png")
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


func _on_day_night_toggle_pressed():
	Global.DayNight = not Global.DayNight
	if Global.DayNight:
		$PauseScreen/DayNightToggle.texture_normal = load("res://FlappyBird/assets/BUTTONS_AND_UI/NIGHT_MODE_BTN.png")
		Global.mode = "night"
	else:
		$PauseScreen/DayNightToggle.texture_normal = load("res://FlappyBird/assets/BUTTONS_AND_UI/LIGHT_MODE_BTN.png")
		Global.mode = "day"

