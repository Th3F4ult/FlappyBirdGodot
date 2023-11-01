extends CharacterBody2D
@onready var fly = $AnimatedSprite2D
@onready var GlobalVars = get_node("/root/Global")
const SPEED = 300.0
const JUMP_VELOCITY = -1200.0
var HasGameStarted = false
var HasAudioPlayed = false
var points=0
var gravity = 0
func _ready():
	fly.play("doingnothing")
	GlobalVars.isDead = false
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y >= 0 and HasGameStarted:
			fly.rotation=70
		elif velocity.y <= 0 and HasGameStarted: 
			fly.rotation = 75
	if Input.is_action_just_pressed("clickedortapped") and HasGameStarted:
		velocity.y = -1200
		$"../Flap".play()
	move_and_slide()
func _on_texture_button_pressed():
	velocity.y = 0
func _on_start_btn_pressed():
			gravity =  ProjectSettings.get_setting("physics/2d/default_gravity") * 3
			HasGameStarted = true
			velocity.y = JUMP_VELOCITY
			$"../start_btn".visible = false
			$"../Flap".play()
func _on_thing_that_kills_us_body_entered(body):
	if body.is_in_group("bird"):
		HasGameStarted = false
		$"../MenuButton".visible = true
		fly.play("death")
		if not HasAudioPlayed:
			$"../DeathAudio".play()
			HasAudioPlayed = true
			$"../TextureButton".visible = false
			$"../Timer".start()
func _on_area_2d_body_exited(body):
	if body.is_in_group("bird"):
		HasGameStarted = false
		$"../MenuButton".visible = true
		fly.play("death")
		if not HasAudioPlayed:
			$"../DeathAudio".play()
			HasAudioPlayed = true
			$"../TextureButton".visible = false
			$"../Timer".start()
func _on_timer_timeout():
	fly.rotation = 0
