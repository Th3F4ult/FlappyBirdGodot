extends CharacterBody2D

var dif = "NoDifficulty"
var DidWeDie = false
var points = 0 
var PIPERNG=RandomNumberGenerator.new()
var SavedRNG_1
var SavedRNG_2

func _ready():
	var y_range = PIPERNG.randf_range(100,1100)
	var random_position=Vector2(500, y_range)
	position = random_position
	$"../POINTS".add_theme_font_size_override("font_size",256)
	$"../POINTS".add_theme_constant_override("outline_size",32)
	$"../POINTS".text = "0"
	$"../MenuButton/FINALPOINTS".add_theme_constant_override("outline_size",16)
func _physics_process(_delta):
	if dif == "E":
		velocity.x = -400
	elif dif == "M":
		velocity.x = -800
	elif dif == "H":
		velocity.x = -1200
	else:
		velocity.x = 0 
	if position.x <= -1300:
		position.x = 500
	move_and_slide() 
func DEATH():
	if not DidWeDie: 
		DidWeDie = true
		Global.lastDif = dif
		velocity.x = 0
		$"../MenuButton/FINALPOINTS".text = str(points)
		$"../MenuButton/Medal1".visible = false
		$"../MenuButton/Medal2".visible = false
		$"../MenuButton/Medal3".visible = false
		$"../MenuButton/Medal4".visible = false
		if points < 11 and points > 5:
			$"../MenuButton/Medal1".visible = true
		elif points > 10 and points < 21:
			$"../MenuButton/Medal2".visible = true
		elif points > 20 and points < 31:
			$"../MenuButton/Medal3".visible = true
		elif points > 32:
			$"../MenuButton/Medal4".visible = true
		dif = null

func AddPoints():
	points = points + 1
	$"../POINTS".text = str(points)
func _on_thing_that_kills_us_body_entered(ThingThatEnteredTheArea):
	if ThingThatEnteredTheArea.is_in_group("bird"):
		DEATH()
func _on_thing_that_counts_our_points_body_entered(body):
	if body.is_in_group("bird"):
		position.x = position.x + 1500
		position.y = PIPERNG.randf_range(100,1100)
#		SavedRNG_1 = PIPERNG.randf_range(-300,-1000)
#		SavedRNG_2 = PIPERNG.randf_range(1500,1800)
#		$Thing_that_kills_us/CollisionShape2D.position.y = SavedRNG_1
#		$Thing_that_kills_us/PIPEPOINTINGDOWN.position.y = SavedRNG_1
#		$Thing_that_kills_us/PIPEPOINTINGUP.position.y = SavedRNG_2
#		$Thing_that_kills_us/CollisionShape2D2.position.y = SavedRNG_2+100
func _on_start_btn_pressed():
	if not Global.lastDif == null:
		dif = Global.lastDif
	else:
		dif = "M"	
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
