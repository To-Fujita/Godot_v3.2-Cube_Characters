extends KinematicBody


const speed = 20

var mouse_sens = 0.3
var Player
var Temp
var joystickVector
var Player_quat_s = Quat(0, 0, 0, 0)
var Player_quat_g = Quat(0, 0, 0, 0)
var Player_quat_t = 0.2
var Flag = 0


func _ready():
	get_node("AnimationPlayer").get_animation("Stop").loop = false
	get_node("AnimationPlayer").get_animation("Walk").loop = true
	get_node("AnimationPlayer").get_animation("Look_Around_L").loop = false
	get_node("AnimationPlayer").get_animation("Look_Around_R").loop = false
	get_node("AnimationPlayer").get_animation("No").loop = false
	get_node("AnimationPlayer").get_animation("Nod").loop = false
	get_node("AnimationPlayer").get_animation("Question_L").loop = false
	get_node("AnimationPlayer").get_animation("Question_R").loop = false
	Player = get_node(".")
	Player_quat_s = Quat(Vector3(0, 1, 0), atan2(0, 0))
	Temp = get_node("../JoyStick").connect('move', self, '_on_JoystickMove')


func _process(_delta):
	player_move()


"""
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed():
				status = "clicked"
			else:
				status = "released"
	if event is InputEventMouseMotion:
		if status == "clicked":
			$Spatial_Ginbal.rotate_y(deg2rad(-event.relative.x * mouse_sens))
			var changev = -event.relative.y * mouse_sens
			if camera_anglev + changev > -50 and camera_anglev + changev < 50:
				camera_anglev += changev
				$Spatial_Ginbal.rotate_x(deg2rad(changev))
"""


func _on_JoystickMove(vector):
	if vector.length() > 0:
#		print(vector)
		get_node("AnimationPlayer").play("Walk")
		var force = Vector3(vector.x, 0, vector.y).normalized() * speed
		Player.move_and_slide(force, Vector3())									# ８方向移動
		Player_quat_g = Quat(Vector3(0, 1, 0), atan2(vector.x, vector.y))
		Player_quat_s = Player_quat_s.slerp(Player_quat_g, Player_quat_t)
		Player.transform = Transform(Player_quat_s)
		Player.scale = Vector3(0.3, 0.3, 0.3)
		Player.transform.origin.y = 0.9
	else:
		get_node("AnimationPlayer").play("Stop")
		Player.scale = Vector3(0.3, 0.3, 0.3)
		Player.transform.origin.y = 0.9


func player_move():
	var direction = Vector3()
	if Input.is_key_pressed(KEY_S):
		get_node("AnimationPlayer").play("Stop")
	if Input.is_key_pressed(KEY_W):
		get_node("AnimationPlayer").play("Walk")
	if Input.is_key_pressed(KEY_L):
		get_node("AnimationPlayer").play("Look_Around_L")
	if Input.is_key_pressed(KEY_R):
		get_node("AnimationPlayer").play("Look_Around_R")
	if Input.is_key_pressed(KEY_N):
		get_node("AnimationPlayer").play("No")
	if Input.is_key_pressed(KEY_M):
		get_node("AnimationPlayer").play("Nod")
	if Input.is_key_pressed(KEY_Q):
		get_node("AnimationPlayer").play("Question_L")
	if Input.is_key_pressed(KEY_A):
		get_node("AnimationPlayer").play("Question_R")
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1
	
	if direction.length() > 0:
		Flag = 1
		var force = direction.normalized() * speed
		Player_quat_g = Quat(Vector3(0, 1, 0), atan2(direction.x, direction.z))
		Player_quat_s = Player_quat_s.slerp(Player_quat_g, Player_quat_t)
		Player.transform = Transform(Player_quat_s)
		Temp = Player.move_and_slide(force, Vector3(1, 0, 1))
		get_node("AnimationPlayer").play("Walk")
		Player.scale = Vector3(0.3, 0.3, 0.3)
		Player.transform.origin.y = 0.9
	elif Flag == 1:
		get_node("AnimationPlayer").play("Stop")
		Player.scale = Vector3(0.3, 0.3, 0.3)
		Player.transform.origin.y = 0.9
		Flag = 0



