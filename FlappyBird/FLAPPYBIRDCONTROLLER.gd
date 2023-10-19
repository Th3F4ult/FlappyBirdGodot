# This file, probably to no one's surprise, controls the "Bird", and I can't
# For the love of God make the physics similar to the OG Flappy Bird, feel
# Free to tweak around, but if you wanna make it easier (Or harder!) you
# Should check the file "PIPE_GENERATION_TOP.gd"

extends CharacterBody2D

@onready var fly = $AnimatedSprite2D
@onready var GlobalVars = get_node("/root/Global")
const SPEED = 300.0
const JUMP_VELOCITY = -1200.0
var HasGameStarted = false # Hacky stuff that just KINDA works ig
var HasAudioPlayed = false # Hacky workaround to not hear the "Peww" from hitting something twice
var points=0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 0

func _ready():
	fly.play("doingnothing") # doingnothing is just the wing movement in question
	GlobalVars.isDead = false
#	fly.connect(animation_finished , self, function)
#
#func function():
#	fly.play("doingnothing")

# FUCK ANIMATED SPRITES

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

		if velocity.y >= 0 and HasGameStarted:
			fly.rotation=70
		elif velocity.y <= 0 and HasGameStarted: 
			fly.rotation = 75
		print(velocity.y)

	if Input.is_action_just_pressed("clickedortapped") and HasGameStarted:
		velocity.y = -1200
		$"../Flap".play()
		
#		fly.rotation=75

		
# Move the sprite up and down (To simulate going up and down)
	move_and_slide()




func _on_texture_button_pressed():
	velocity.y = 0
	position.y = position.y - -100
	# This is a hacky fix, but it works, and if it works, it's good. (Can't "unhandle"
	# the press on the button, as it gets caught by this (CharacterBody2D) and it makes
	# the bird go up, as if we had pressed outside the pause button) This is
	# somewhat ok, but it might be a couple pixels off, will fix later.


func _on_start_btn_pressed():
			gravity =  ProjectSettings.get_setting("physics/2d/default_gravity") * 3
			HasGameStarted = true
			velocity.y = JUMP_VELOCITY
			$"../start_btn".visible = false
			$"../Flap".play()
# Starts the game

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
# These 2 functions handle death

func _on_timer_timeout():
	fly.rotation = 0
	# This is suposed to like make it stop from moving on death, but this
	# Doesn't work, just let it rotate I guess.
	# timer is 0.15 seconds. It can be almost whatever number from 0.1>
