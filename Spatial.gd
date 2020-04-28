extends Spatial


const Run_speed = 5
const Walk_speed = 2

var speed = 2
var mouse_sens = 0.3
var Player_000
var Player_001
var Player_002
var Player_003
var Temp
var joystickVector
var Player_quat_s = Quat(0, 1, 0, 0)
var Player_quat_g = Quat(0, 1, 0, 0)
var Player_quat_t = 0.2
var Flag = 0
var Walk_Flag = 0


func _ready():
	get_node("KinematicBody_001/AnimationPlayer").get_animation("Fall_Down").loop = false
	get_node("KinematicBody_001/AnimationPlayer").get_animation("Jump").loop = false
	get_node("KinematicBody_001/AnimationPlayer").get_animation("Look_Around_L").loop = false
	get_node("KinematicBody_001/AnimationPlayer").get_animation("Look_Around_R").loop = false
	get_node("KinematicBody_001/AnimationPlayer").get_animation("Nod").loop = false
	get_node("KinematicBody_001/AnimationPlayer").get_animation("Question_L").loop = false
	get_node("KinematicBody_001/AnimationPlayer").get_animation("Question_R").loop = false
	get_node("KinematicBody_001/AnimationPlayer").get_animation("Run").loop = true
	get_node("KinematicBody_001/AnimationPlayer").get_animation("Shake_Head").loop = false
	get_node("KinematicBody_001/AnimationPlayer").get_animation("Stop").loop = false
	get_node("KinematicBody_001/AnimationPlayer").get_animation("Walk").loop = true
	get_node("KinematicBody_001/AnimationPlayer").get_animation("Walk_1").loop = true
	Player_000 = get_node("KinematicBody_000")
	Player_001 = get_node("KinematicBody_001")
	Player_002 = get_node("KinematicBody_002")
	Player_003 = get_node("KinematicBody_003")
	Temp = get_node("JoyStick").connect('move', self, '_on_JoystickMove')


func _process(_delta):
	player_move()


func _on_JoystickMove(vector):
	if vector.length() > 0:
		var force = Vector3(vector.x, 0, vector.y).normalized() * speed
#		print(vector, " / ", force)
#		Player_quat_g = Quat(Vector3(0, 1, 0), atan2(vector.x, vector.y))
#		Player_quat_s = Player_quat_s.slerp(Player_quat_g, Player_quat_t)
#		Player.transform = Transform(Player_quat_s)								# Not work well
		Player_000.rotation.y = atan2(vector.x, vector.y)
		Player_000.move_and_slide(force, Vector3(1, 0, 1))
		Player_001.rotation.y = atan2(vector.x, vector.y)
		Player_001.move_and_slide(force, Vector3(1, 0, 1))
		Player_002.rotation.y = atan2(vector.x, vector.y)
		Player_002.move_and_slide(force, Vector3(1, 0, 1))
		Player_003.rotation.y = atan2(vector.x, vector.y)
		Player_003.move_and_slide(force, Vector3(1, 0, 1))
		get_node("KinematicBody_000/AnimationPlayer").play("Walk_1")
		get_node("KinematicBody_001/AnimationPlayer").play("Walk")
		get_node("KinematicBody_002/AnimationPlayer").play("Walk")
		get_node("KinematicBody_003/AnimationPlayer").play("Walk")
	else:
		get_node("KinematicBody_000/AnimationPlayer").play("Stop")
		get_node("KinematicBody_001/AnimationPlayer").play("Stop")
		get_node("KinematicBody_002/AnimationPlayer").play("Stop")
		get_node("KinematicBody_003/AnimationPlayer").play("Stop")


func player_move():
	var direction = Vector3()
	if Input.is_key_pressed(KEY_F):
		get_node("KinematicBody_001/AnimationPlayer").play("Fall_Down")
	if Input.is_key_pressed(KEY_J):
		get_node("KinematicBody_001/AnimationPlayer").play("Jump")
	if Input.is_key_pressed(KEY_L):
		get_node("KinematicBody_001/AnimationPlayer").play("Look_Around_L")
	if Input.is_key_pressed(KEY_R):
		get_node("KinematicBody_001/AnimationPlayer").play("Look_Around_R")
	if Input.is_key_pressed(KEY_N):
		get_node("KinematicBody_001/AnimationPlayer").play("Nod")
	if Input.is_key_pressed(KEY_M):
		get_node("KinematicBody_001/AnimationPlayer").play("Shake_Head")
	if Input.is_key_pressed(KEY_Q):
		get_node("KinematicBody_001/AnimationPlayer").play("Question_L")
	if Input.is_key_pressed(KEY_A):
		get_node("KinematicBody_001/AnimationPlayer").play("Question_R")
	if Input.is_key_pressed(KEY_T):
		get_node("KinematicBody_001/AnimationPlayer").play("Run")
		Walk_Flag = 2
		speed = Run_speed
	if Input.is_key_pressed(KEY_S):
		get_node("KinematicBody_001/AnimationPlayer").play("Stop")
	if Input.is_key_pressed(KEY_W):
		get_node("KinematicBody_001/AnimationPlayer").play("Walk")
		Walk_Flag = 0
		speed = Walk_speed
	if Input.is_key_pressed(KEY_E):
		get_node("KinematicBody_001/AnimationPlayer").play("Walk_1")
		Walk_Flag = 1
		speed = Walk_speed
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
#		Player_quat_g = Quat(Vector3(0, 1, 0), atan2(direction.x, direction.z))
#		Player_quat_s = Player_quat_s.slerp(Player_quat_g, Player_quat_t)
#		Player.transform = Transform(Player_quat_s)								# Not work well
		Player_001.rotation.y = atan2(direction.x, direction.z)
		Player_001.move_and_slide(force, Vector3(1, 0, 1))
		if Walk_Flag == 2:
			get_node("KinematicBody_001/AnimationPlayer").play("Run")
		elif Walk_Flag == 1:
			get_node("KinematicBody_001/AnimationPlayer").play("Walk_1")
		else:
			get_node("KinematicBody_001/AnimationPlayer").play("Walk")
	elif Flag == 1:
		get_node("KinematicBody_001/AnimationPlayer").play("Stop")
		Flag = 0

