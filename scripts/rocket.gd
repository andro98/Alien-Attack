extends Area2D

const ROCKET_SPEED = 500.0

func _physics_process(delta):
	global_position.x += ROCKET_SPEED * delta
 
func _on_visible_notifire_screen_exited():
	queue_free()


func _on_area_entered(area):
	queue_free()
	area.die()
