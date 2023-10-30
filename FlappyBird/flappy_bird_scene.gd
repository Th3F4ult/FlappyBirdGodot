# This contains a lot of random bullshit that I couldn't fit anywhere else
# At least not with having """good""" (as good as I can) code
# This file should not exist. It should NOT exist.

extends Node2D

#var pipe_scene = preload("res://FlappyBird/OtherPipes.tscn")
# I was packing up and getting things ready to upload them to Github
# When I stumbled about this failing
# Turns out I deleted this scene since it's not needed LOL
# That was like 20 minutes trying to find out what was wrong



func _ready():
	#get_node("ParallaxBackground")._process(delta)
	#$POINTS_RN.add_theme_font_size_override("font_size",32)
	$PauseScreen.visible = false # Do this
	$MenuButton.visible = false
	$MenuButton/FINALPOINTS.add_theme_font_size_override("font_size", 96)
	# Ideally we would have cool looking points, but whatever




func PAUSEPRESS():
	#print("Pause Button Has Been Pressed")
	# Shit kinda worked sometimes so I added this for convenience. 
	# Not needed anymore.
	$TextureButton.visible = not $TextureButton.visible
	get_tree().paused = not get_tree().paused
	$PauseScreen.visible = not $PauseScreen.visible


func _on_unpause_pressed():
	$TextureButton.visible = not $TextureButton.visible
	get_tree().paused = not get_tree().paused
	$PauseScreen.visible = not $PauseScreen.visible
# The "Play" button


func _on_retry_pressed():
	queue_free() # Because if we don't do this the pipes sometimes don't move?? Idk really but this fixes it
	get_tree().change_scene_to_file("res://FlappyBird/flappy_bird_scene.tscn")
# Maybe... Just maybe we should ask for confirmation.

func _on_menu_pressed():
	get_tree().quit()
# This crashes the game, it's in-
# Nvm turns out I was using the wrong call
