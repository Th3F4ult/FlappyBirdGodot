# This script handles both Pipe "Generation" (Moving them to the next chunk)
# and all the death screen logic, assigning a medal, and showing points in there.
# "Exit" (Menu) and "Retry" (Retry) buttons are handled in  flappy_bird_scene.gd


extends CharacterBody2D
var dif = "NoDificulty"
var points = 0 # We set up the "points" variable, this is where we store the points
var PIPERNG=RandomNumberGenerator.new() # RNG stuff
#var pipe_scene = preload("res://FlappyBird/OtherPipes.tscn")
#Not needed anymore
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#Since we don't control the pipes, nor they move in the Y axis, we just get rid of this


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	var y_range = PIPERNG.randf_range(100,1100)
	var random_position=Vector2(500, y_range)
	position = random_position # This could be done in a single variable, will fix.
	$"../POINTS".add_theme_font_size_override("font_size",128) # Make it bigger for bigger point display
	$"../POINTS".add_theme_constant_override("outline_size",8)

func _physics_process(delta):
	print(velocity.x, " Dif: ", dif)
	if dif == "E":
		velocity.x = -400
	elif dif == "M":
		velocity.x = -800
	elif dif == "H":
		velocity.x = -1200
	else:
		velocity.x = 0 
	move_and_slide() # This is basically... the thing that makes it move


func DEATH():
	#print("This person died")
	# Debugging stuff
	velocity.x = 0 # Stop the pipe
	$"../MenuButton/FINALPOINTS".text = str(points) # Show the score
	if points < 6:
		$"../MenuButton/Medal4".visible = false
		$"../MenuButton/Medal3".visible = false 
		$"../MenuButton/Medal1".visible = false
		$"../MenuButton/Medal2".visible = false
# If we have less than 6, (5 or less) we have no medal
	if points < 11 and points > 5:
		$"../MenuButton/Medal4".visible = false
		$"../MenuButton/Medal3".visible = false 
		$"../MenuButton/Medal2".visible = false
	elif points > 10 and points < 21:
		$"../MenuButton/Medal4".visible = false
		$"../MenuButton/Medal3".visible = false 
		$"../MenuButton/Medal1".visible = false
	elif points > 20 and points < 31:
		$"../MenuButton/Medal4".visible = false
		$"../MenuButton/Medal1".visible = false 
		$"../MenuButton/Medal2".visible = false
	else:
		$"../MenuButton/Medal2".visible = false
		$"../MenuButton/Medal3".visible = false 
		$"../MenuButton/Medal1".visible = false
# Maybe this could be done BETTER with arrays, something like
# var Medals = [../MenuButton/Medal1, ../MenuButton/Medal2...] but I'm too
# lazy to actually do it
	dif = "STOPGAME"

func AddPoints():
	points = points + 1
	$"../POINTS".text = str(points)
#func RefreshCounter():
#	$"../POINTS".text = str(points)
# Maybe we could do this with just a single function?

func _on_thing_that_kills_us_body_entered(ThingThatEnteredTheArea):
	if ThingThatEnteredTheArea.is_in_group("bird"):
		DEATH()





func _on_thing_that_counts_our_points_body_entered(body):
	if body.is_in_group("bird"):
		position.x = position.x + 1550
		position.y = PIPERNG.randf_range(100,1100)
	




func _on_start_btn_pressed():
	dif = "M"
		# This is here just in case I missed anything, to have a safe value
		# and not have the pipes stuck in nowhere forever

func _on_thing_that_dings_body_entered(body):
	if body.is_in_group("bird"):
		$"../DingDingDings".play()
		AddPoints()


func _on_area_2d_body_exited(body):
	if body.is_in_group("bird"):
		DEATH()


func _on_easy_button_pressed():
	dif = "E"



func _on_medium_button_pressed():
	dif = "M"


func _on_hard_button_pressed():
	dif = "H"
