
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var screen_size
var pad_size
var ball_speed =  80
var direction = Vector2(-1,0) #direction of the ball
const PAD_SPEED = 150

func _process(delta):
	var ball_pos = get_node("ball").get_pos() #where is the ball
	var left_rect = Rect2( get_node("left").get_pos() - pad_size/2, pad_size )
	#the left side (Sprite is centered!)
	var right_rect = Rect2( get_node("right").get_pos() - pad_size/2, pad_size)
	#same for the right side

	ball_pos += direction * ball_speed * delta

	#lets test the state of the ball while it moves!
	if( ( ball_pos.y < 0 and direction.y < 0 ) or ( ball_pos.y > screen_size.y and direction.y > 0) ):
		direction.y = -direction.y

	#also when it touches a PAD
	if( ( left_rect.has_point( ball_pos ) and direction.x < 0 ) or ( right_rect.has_point( ball_pos ) and direction.x > 0 ) ):
		direction.x = -direction.x
		ball_speed *= 1.1
		direction.y = randf() * 2.0 - 1
		direction = direction.normalized()
	
	#when the balls falls out of the LEFT || RIGHT sides
	if( ball_pos.x < 0 or ball_pos.x > screen_size.x ):
		ball_pos = screen_size * 0.5 #the ball goes to the center of the screen to restart the ball!!
		ball_speed = 80
		direction = Vector2( -1,0 )
	
	#we already checked everything needed for the ball, now we just need to update the NODE
	get_node( "ball" ).set_pos( ball_pos )
	
	#lets get done with the player input (the pads)
	#	LEFT PAD
	var left_pos = get_node( "left" ).get_pos()
	
	if( left_pos.y > 0 and Input.is_action_pressed( "left_move_up" ) ):
		left_pos.y += -PAD_SPEED * delta
	if( left_pos.y < screen_size.y and Input.is_action_pressed( "left_move_down" ) ):
		left_pos.y += PAD_SPEED * delta
	
	get_node( "left" ).set_pos( left_pos )
	
	#	RIGHT PAD
	var right_pos = get_node( "right" ).get_pos()
	
	if( right_pos.y > 0 and Input.is_action_pressed( "right_move_up" ) ):
		right_pos.y += -PAD_SPEED * delta
	if( right_pos.y < screen_size.y and Input.is_action_pressed( "right_move_down" ) ):
		right_pos.y += PAD_SPEED * delta
	
	get_node( "right" ).set_pos( right_pos )
	
func _ready():

	screen_size = get_viewport_rect().size
	pad_size = get_node("left").get_texture().get_size()
	set_process(true)
	# Called every time the node is added to the scene.
	# Initialization here