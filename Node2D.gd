
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var screen_size
var pad_size
var ball_speed =  80
var direction = Vector2(-1,0) #direction of the ball
const PAD_SPEED = 150

func _ready():
	screen_size = get_viewport_rect().size
	pad_size = get_node("left").get_texture().get_size()
	set_process(true)
	# Called every time the node is added to the scene.
	# Initialization here
	pass

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


