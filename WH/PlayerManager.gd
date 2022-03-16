extends KinematicBody

const MOVE_SPEED = 10
const MOUSE_SENS = 0.001

var camera_mode = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENS)
		$Pivot.rotate_x(-event.relative.y * MOUSE_SENS)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2)
		
func _physics_process(delta):
	if camera_mode:
		var hor = int(Input.is_action_pressed("move_forwards")) - int(Input.is_action_pressed("move_backwards"))
		var vec = int(Input.is_action_pressed("move_left")) - int(Input.is_action_pressed("move_right"))
		var move_vec = Vector3(vec,0,hor)
		move_vec = move_vec.normalized()
		move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
		move_and_collide(move_vec * MOVE_SPEED * delta)
	
	if Input.is_action_just_pressed("toggle_camera"):
		camera_mode = !camera_mode
		if camera_mode:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			$Camera.current = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			$Camera.current = false
