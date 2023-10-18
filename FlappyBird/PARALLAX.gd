# Controls the parallax (As you can guess)
extends ParallaxBackground

@onready var GlobalVars = get_node("/root/Global")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVars.isDead:
		#print("DEAD")
		pass
# If we don't do this, the parallax stops for a frame and continues.
	else:
		scroll_offset.x += 500 * -delta


func _on_thing_that_kills_us_body_entered(body):
	if body.is_in_group("bird"):
		scroll_offset.x = scroll_offset.x
		GlobalVars.isDead =  true



func _on_area_2d_body_exited(body):
	if body.is_in_group("bird"):
		scroll_offset.x = scroll_offset.x
		GlobalVars.isDead =  true


# I couldn't get a singleton to work with the isDead variable so we gotta
# Add it and it's logic to EVERYTHING that needs to do smth on death, like
# In this case, stopping the parallax background
