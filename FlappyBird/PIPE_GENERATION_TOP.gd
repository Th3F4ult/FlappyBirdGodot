extends CharacterBody2D
@onready var vars = get_node("/root/Global")
var dif = "NoDifficulty"
var DidWeDie = false
var points = 0 
var PIPERNG=RandomNumberGenerator.new()
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	var y_range = PIPERNG.randf_range(100,1100)
	var random_position=Vector2(500, y_range)
	position = random_position
	$"../POINTS".add_theme_font_size_override("font_size",128)
	$"../POINTS".add_theme_constant_override("outline_size",8)
	
func _physics_process(delta):
	if dif == "E":
		velocity.x = -400
	elif dif == "M":
		velocity.x = -800
	elif dif == "H":
		velocity.x = -1200
	else:
		velocity.x = 0 
	move_and_slide() 
func DEATH():
	if not DidWeDie: 
		DidWeDie = true
		vars.lastDif = dif
		print(dif," > lastDif (",vars.lastDif,")")
		velocity.x = 0
		$"../MenuButton/FINALPOINTS".text = str(points)
		$"../MenuButton/Medal1".visible = false
		$"../MenuButton/Medal2".visible = false
		$"../MenuButton/Medal3".visible = false
		$"../MenuButton/Medal4".visible = false
		if points < 6:
			pass
		if points < 11 and points > 5:
			$"../MenuButton/Medal1".visible = true
		elif points > 10 and points < 21:
			$"../MenuButton/Medal2".visible = true
		elif points > 20 and points < 31:
			$"../MenuButton/Medal3".visible = true
		elif points > 32:
			$"../MenuButton/Medal4".visible = true
		dif = null
	else:
		print("We're already dead, not dying again")
func AddPoints():
	points = points + 1
	$"../POINTS".text = str(points)
func _on_thing_that_kills_us_body_entered(ThingThatEnteredTheArea):
	if ThingThatEnteredTheArea.is_in_group("bird"):
		DEATH()
func _on_thing_that_counts_our_points_body_entered(body):
	if body.is_in_group("bird"):
		position.x = position.x + 1550
		position.y = PIPERNG.randf_range(100,1100)
func _on_start_btn_pressed():
	if not vars.lastDif == null:
		dif = vars.lastDif
	else:
		dif = "M"
	print("Starting on ", dif, " difficulty")
func _on_thing_that_dings_body_entered(body):
	if body.is_in_group("bird"):
		$"../DingDingDings".play()
		AddPoints()
func _on_area_2d_body_exited(body):
	if body.is_in_group("bird"):
		DEATH()
func _on_easy_button_pressed():
	dif = "E"
	Global.ParallaxSpeed = 0.005
func _on_medium_button_pressed():
	dif = "M"
	Global.ParallaxSpeed = 0.01
func _on_hard_button_pressed():
	dif = "H"
	Global.ParallaxSpeed = 0.03
