extends ParallaxBackground
func _process(delta):
	if Global.isDead:
		pass
	else:
		scroll_offset.x += 500 * -Global.ParallaxSpeed
func _on_thing_that_kills_us_body_entered(body):
	if body.is_in_group("bird"):
		scroll_offset.x = scroll_offset.x
		Global.isDead =  true
func _on_area_2d_body_exited(body):
	if body.is_in_group("bird"):
		scroll_offset.x = scroll_offset.x
		Global.isDead =  true
