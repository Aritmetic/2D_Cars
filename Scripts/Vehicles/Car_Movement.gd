extends KinematicBody2D

export (int) var MaxSpeed = 10
export (float) var RotationSpeed = 1.5

onready var Camera = $Camera2D
onready var LeftWheel = $LeftWheel
onready var RightWheel = $RightWheel

var Velocity : Vector2 = Vector2()
var RotationDirection : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Camera.current = true
	# Camera.make_current(true)
	pass # Replace with function body.

func GetInput():

	RotationDirection = 0
	if Input.is_action_pressed( "left" ):
		RotationDirection = -1
	elif Input.is_action_pressed( "right" ):
		RotationDirection = 1

	if Input.is_action_pressed("forward"):
		Velocity = Vector2(MaxSpeed, 0)
	elif Input.is_action_pressed( "backward" ):
		Velocity = Vector2(-MaxSpeed, 0)
	pass

func _physics_process(delta):
	GetInput()
	# only turn when Body has Velocity
	if 0.1 < Velocity.length():
		if Velocity.x < 0:
			rotation -= RotationDirection * RotationSpeed * delta
		else:
			rotation += RotationDirection * RotationSpeed * delta
	LeftWheel.rotation = deg2rad( 90 + (RotationDirection * 45) )
	RightWheel.rotation = LeftWheel.rotation

	Velocity = move_and_slide( Velocity.rotated(rotation) )
	Velocity = Vector2.ZERO
