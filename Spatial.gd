extends Spatial


const Run_speed = 5
const Walk_speed = 2
const Cube_Data = 10

var speed = 2
var mouse_sens = 0.3
var Player_000
var Player_001
var Player_002
var Player_003
var Temp
var joystickVector
var Mouse_pos = Vector2()
var Player_quat_s = Quat(0, 1, 0, 0)
var Player_quat_g = Quat(0, 1, 0, 0)
var Player_quat_t = 0.2
var Flag = 0
var Walk_Flag = 0
var Cube_Textures = []
var Texture_No = 0
var direction = Vector3(0, 0, 0)


func _ready():
	get_node("KinematicBody_000/AnimationPlayer").get_animation("Fall_Down").loop = false
	get_node("KinematicBody_000/AnimationPlayer").get_animation("Jump").loop = false
	get_node("KinematicBody_000/AnimationPlayer").get_animation("Look_Around_L").loop = false
	get_node("KinematicBody_000/AnimationPlayer").get_animation("Look_Around_R").loop = false
	get_node("KinematicBody_000/AnimationPlayer").get_animation("Nod").loop = false
	get_node("KinematicBody_000/AnimationPlayer").get_animation("Question_L").loop = false
	get_node("KinematicBody_000/AnimationPlayer").get_animation("Question_R").loop = false
	get_node("KinematicBody_000/AnimationPlayer").get_animation("Run").loop = true
	get_node("KinematicBody_000/AnimationPlayer").get_animation("Shake_Head").loop = false
	get_node("KinematicBody_000/AnimationPlayer").get_animation("Stop").loop = false
	get_node("KinematicBody_000/AnimationPlayer").get_animation("Walk").loop = true
	get_node("KinematicBody_000/AnimationPlayer").get_animation("Walk_1").loop = true
	Player_000 = get_node("KinematicBody_000")
	Player_001 = get_node("KinematicBody_001")
	Player_002 = get_node("KinematicBody_002")
	Player_003 = get_node("KinematicBody_003")
	Temp = get_node("JoyStick").connect('move', self, '_on_JoystickMove')
	for i in range(Cube_Data):
		Cube_Textures.append([])
		for j in range(10):
			Cube_Textures[i].append([])
			Cube_Textures[i][j] = SpatialMaterial.new()
			if i == 0:
				Cube_Textures[i][j].albedo_texture = load("res://images/ABC.png")
	for i in range(1, Cube_Data):
		var Temp_Body = "res://images/Cube_A_00" + String(i) + "/Body.png"
		var Temp_Head = "res://images/Cube_A_00" + String(i) + "/Head.png"
		var Temp_Arm_L_1 = "res://images/Cube_A_00" + String(i) + "/Arm_L_1.png"
		var Temp_Arm_L_2 = "res://images/Cube_A_00" + String(i) + "/Arm_L_2.png"
		var Temp_Arm_R_1 = "res://images/Cube_A_00" + String(i) + "/Arm_R_1.png"
		var Temp_Arm_R_2 = "res://images/Cube_A_00" + String(i) + "/Arm_R_2.png"
		var Temp_Leg_L_1 = "res://images/Cube_A_00" + String(i) + "/Leg_L_1.png"
		var Temp_Leg_L_2 = "res://images/Cube_A_00" + String(i) + "/Leg_L_2.png"
		var Temp_Leg_R_1 = "res://images/Cube_A_00" + String(i) + "/Leg_R_1.png"
		var Temp_Leg_R_2 = "res://images/Cube_A_00" + String(i) + "/Leg_R_2.png"
		Cube_Textures[i][0].albedo_texture = load(Temp_Body)
		Cube_Textures[i][1].albedo_texture = load(Temp_Head)
		Cube_Textures[i][2].albedo_texture = load(Temp_Arm_L_1)
		Cube_Textures[i][3].albedo_texture = load(Temp_Arm_L_2)
		Cube_Textures[i][4].albedo_texture = load(Temp_Arm_R_1)
		Cube_Textures[i][5].albedo_texture = load(Temp_Arm_R_2)
		Cube_Textures[i][6].albedo_texture = load(Temp_Leg_L_1)
		Cube_Textures[i][7].albedo_texture = load(Temp_Leg_L_2)
		Cube_Textures[i][8].albedo_texture = load(Temp_Leg_R_1)
		Cube_Textures[i][9].albedo_texture = load(Temp_Leg_R_2)
		

func _process(_delta):
	player_move()


func _on_JoystickMove(vector):
	if Mouse_pos.x < 160:
		return
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
	if Input.is_key_pressed(KEY_0) or Texture_No == 0:
		Texture_No = 0
		get_node("KinematicBody_000/MeshInstance_Body").set_surface_material(0, Cube_Textures[0][0])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Head").set_surface_material(0, Cube_Textures[0][1])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1").set_surface_material(0, Cube_Textures[0][2])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1/MeshInstance_Arm_L2").set_surface_material(0, Cube_Textures[0][3])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1").set_surface_material(0, Cube_Textures[0][4])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1/MeshInstance_Arm_R2").set_surface_material(0, Cube_Textures[0][5])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1").set_surface_material(0, Cube_Textures[0][6])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1/MeshInstance_Leg_L2").set_surface_material(0, Cube_Textures[0][7])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1").set_surface_material(0, Cube_Textures[0][8])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1/MeshInstance_Leg_R2").set_surface_material(0, Cube_Textures[0][9])
	if Input.is_key_pressed(KEY_1) or Texture_No == 1:
		Texture_No = 1
		get_node("KinematicBody_000/MeshInstance_Body").set_surface_material(0, Cube_Textures[1][0])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Head").set_surface_material(0, Cube_Textures[1][1])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1").set_surface_material(0, Cube_Textures[1][2])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1/MeshInstance_Arm_L2").set_surface_material(0, Cube_Textures[1][3])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1").set_surface_material(0, Cube_Textures[1][4])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1/MeshInstance_Arm_R2").set_surface_material(0, Cube_Textures[1][5])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1").set_surface_material(0, Cube_Textures[1][6])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1/MeshInstance_Leg_L2").set_surface_material(0, Cube_Textures[1][7])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1").set_surface_material(0, Cube_Textures[1][8])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1/MeshInstance_Leg_R2").set_surface_material(0, Cube_Textures[1][9])
	if Input.is_key_pressed(KEY_2) or Texture_No == 2:
		Texture_No = 2
		get_node("KinematicBody_000/MeshInstance_Body").set_surface_material(0, Cube_Textures[2][0])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Head").set_surface_material(0, Cube_Textures[2][1])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1").set_surface_material(0, Cube_Textures[2][2])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1/MeshInstance_Arm_L2").set_surface_material(0, Cube_Textures[2][3])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1").set_surface_material(0, Cube_Textures[2][4])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1/MeshInstance_Arm_R2").set_surface_material(0, Cube_Textures[2][5])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1").set_surface_material(0, Cube_Textures[2][6])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1/MeshInstance_Leg_L2").set_surface_material(0, Cube_Textures[2][7])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1").set_surface_material(0, Cube_Textures[2][8])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1/MeshInstance_Leg_R2").set_surface_material(0, Cube_Textures[2][9])
	if Input.is_key_pressed(KEY_3) or Texture_No == 3:
		Texture_No = 3
		get_node("KinematicBody_000/MeshInstance_Body").set_surface_material(0, Cube_Textures[3][0])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Head").set_surface_material(0, Cube_Textures[3][1])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1").set_surface_material(0, Cube_Textures[3][2])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1/MeshInstance_Arm_L2").set_surface_material(0, Cube_Textures[3][3])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1").set_surface_material(0, Cube_Textures[3][4])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1/MeshInstance_Arm_R2").set_surface_material(0, Cube_Textures[3][5])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1").set_surface_material(0, Cube_Textures[3][6])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1/MeshInstance_Leg_L2").set_surface_material(0, Cube_Textures[3][7])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1").set_surface_material(0, Cube_Textures[3][8])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1/MeshInstance_Leg_R2").set_surface_material(0, Cube_Textures[3][9])
	if Input.is_key_pressed(KEY_4) or Texture_No == 4:
		Texture_No = 4
		get_node("KinematicBody_000/MeshInstance_Body").set_surface_material(0, Cube_Textures[4][0])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Head").set_surface_material(0, Cube_Textures[4][1])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1").set_surface_material(0, Cube_Textures[4][2])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1/MeshInstance_Arm_L2").set_surface_material(0, Cube_Textures[4][3])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1").set_surface_material(0, Cube_Textures[4][4])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1/MeshInstance_Arm_R2").set_surface_material(0, Cube_Textures[4][5])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1").set_surface_material(0, Cube_Textures[4][6])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1/MeshInstance_Leg_L2").set_surface_material(0, Cube_Textures[4][7])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1").set_surface_material(0, Cube_Textures[4][8])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1/MeshInstance_Leg_R2").set_surface_material(0, Cube_Textures[4][9])
	if Input.is_key_pressed(KEY_5) or Texture_No == 5:
		Texture_No = 5
		get_node("KinematicBody_000/MeshInstance_Body").set_surface_material(0, Cube_Textures[5][0])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Head").set_surface_material(0, Cube_Textures[5][1])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1").set_surface_material(0, Cube_Textures[5][2])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1/MeshInstance_Arm_L2").set_surface_material(0, Cube_Textures[5][3])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1").set_surface_material(0, Cube_Textures[5][4])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1/MeshInstance_Arm_R2").set_surface_material(0, Cube_Textures[5][5])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1").set_surface_material(0, Cube_Textures[5][6])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1/MeshInstance_Leg_L2").set_surface_material(0, Cube_Textures[5][7])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1").set_surface_material(0, Cube_Textures[5][8])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1/MeshInstance_Leg_R2").set_surface_material(0, Cube_Textures[5][9])
	if Input.is_key_pressed(KEY_6) or Texture_No == 6:
		Texture_No = 6
		get_node("KinematicBody_000/MeshInstance_Body").set_surface_material(0, Cube_Textures[6][0])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Head").set_surface_material(0, Cube_Textures[6][1])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1").set_surface_material(0, Cube_Textures[6][2])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1/MeshInstance_Arm_L2").set_surface_material(0, Cube_Textures[6][3])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1").set_surface_material(0, Cube_Textures[6][4])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1/MeshInstance_Arm_R2").set_surface_material(0, Cube_Textures[6][5])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1").set_surface_material(0, Cube_Textures[6][6])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1/MeshInstance_Leg_L2").set_surface_material(0, Cube_Textures[6][7])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1").set_surface_material(0, Cube_Textures[6][8])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1/MeshInstance_Leg_R2").set_surface_material(0, Cube_Textures[6][9])
	if Input.is_key_pressed(KEY_7) or Texture_No == 7:
		Texture_No = 7
		get_node("KinematicBody_000/MeshInstance_Body").set_surface_material(0, Cube_Textures[7][0])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Head").set_surface_material(0, Cube_Textures[7][1])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1").set_surface_material(0, Cube_Textures[7][2])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1/MeshInstance_Arm_L2").set_surface_material(0, Cube_Textures[7][3])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1").set_surface_material(0, Cube_Textures[7][4])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1/MeshInstance_Arm_R2").set_surface_material(0, Cube_Textures[7][5])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1").set_surface_material(0, Cube_Textures[7][6])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1/MeshInstance_Leg_L2").set_surface_material(0, Cube_Textures[7][7])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1").set_surface_material(0, Cube_Textures[7][8])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1/MeshInstance_Leg_R2").set_surface_material(0, Cube_Textures[7][9])
	if Input.is_key_pressed(KEY_8) or Texture_No == 8:
		Texture_No = 8
		get_node("KinematicBody_000/MeshInstance_Body").set_surface_material(0, Cube_Textures[8][0])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Head").set_surface_material(0, Cube_Textures[8][1])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1").set_surface_material(0, Cube_Textures[8][2])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1/MeshInstance_Arm_L2").set_surface_material(0, Cube_Textures[8][3])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1").set_surface_material(0, Cube_Textures[8][4])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1/MeshInstance_Arm_R2").set_surface_material(0, Cube_Textures[8][5])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1").set_surface_material(0, Cube_Textures[8][6])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1/MeshInstance_Leg_L2").set_surface_material(0, Cube_Textures[8][7])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1").set_surface_material(0, Cube_Textures[8][8])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1/MeshInstance_Leg_R2").set_surface_material(0, Cube_Textures[8][9])
	if Input.is_key_pressed(KEY_9) or Texture_No == 9:
		Texture_No = 9
		get_node("KinematicBody_000/MeshInstance_Body").set_surface_material(0, Cube_Textures[9][0])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Head").set_surface_material(0, Cube_Textures[9][1])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1").set_surface_material(0, Cube_Textures[9][2])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_L1/MeshInstance_Arm_L2").set_surface_material(0, Cube_Textures[9][3])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1").set_surface_material(0, Cube_Textures[9][4])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Arm_R1/MeshInstance_Arm_R2").set_surface_material(0, Cube_Textures[9][5])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1").set_surface_material(0, Cube_Textures[9][6])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_L1/MeshInstance_Leg_L2").set_surface_material(0, Cube_Textures[9][7])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1").set_surface_material(0, Cube_Textures[9][8])
		get_node("KinematicBody_000/MeshInstance_Body/MeshInstance_Leg_R1/MeshInstance_Leg_R2").set_surface_material(0, Cube_Textures[9][9])
		
	if Input.is_key_pressed(KEY_F):
		get_node("KinematicBody_000/AnimationPlayer").play("Fall_Down")
	if Input.is_key_pressed(KEY_J):
		get_node("KinematicBody_000/AnimationPlayer").play("Jump")
	if Input.is_key_pressed(KEY_L):
		get_node("KinematicBody_000/AnimationPlayer").play("Look_Around_L")
	if Input.is_key_pressed(KEY_K):
		get_node("KinematicBody_000/AnimationPlayer").play("Look_Around_R")
	if Input.is_key_pressed(KEY_N):
		get_node("KinematicBody_000/AnimationPlayer").play("Nod")
	if Input.is_key_pressed(KEY_M):
		get_node("KinematicBody_000/AnimationPlayer").play("Shake_Head")
	if Input.is_key_pressed(KEY_Q):
		get_node("KinematicBody_000/AnimationPlayer").play("Question_L")
	if Input.is_key_pressed(KEY_A):
		get_node("KinematicBody_000/AnimationPlayer").play("Question_R")
	if Input.is_key_pressed(KEY_R):
		get_node("KinematicBody_000/AnimationPlayer").play("Run")
		Walk_Flag = 2
		speed = Run_speed
	if Input.is_key_pressed(KEY_S):
		get_node("KinematicBody_000/AnimationPlayer").play("Stop")
		direction.x = 0
		direction.z = 0
	if Input.is_key_pressed(KEY_W):
		get_node("KinematicBody_000/AnimationPlayer").play("Walk")
		Walk_Flag = 0
		speed = Walk_speed
	if Input.is_key_pressed(KEY_E):
		get_node("KinematicBody_000/AnimationPlayer").play("Walk_1")
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
		Player_000.rotation.y = atan2(direction.x, direction.z)
		Player_000.move_and_slide(force, Vector3(1, 0, 1))
		if Walk_Flag == 2:
			get_node("KinematicBody_000/AnimationPlayer").play("Run")
		elif Walk_Flag == 1:
			get_node("KinematicBody_000/AnimationPlayer").play("Walk_1")
		else:
			get_node("KinematicBody_000/AnimationPlayer").play("Walk")
	elif Flag == 1:
		get_node("KinematicBody_000/AnimationPlayer").play("Stop")
		Flag = 0


func _input(event):
	if event is InputEventMouseMotion:
		Mouse_pos = event.position


func _on_Button_L_pressed():
	get_node("KinematicBody_000/AnimationPlayer").play("Look_Around_L")


func _on_Button_K_pressed():
	get_node("KinematicBody_000/AnimationPlayer").play("Look_Around_R")


func _on_Button_M_pressed():
	get_node("KinematicBody_000/AnimationPlayer").play("Shake_Head")


func _on_Button_N_pressed():
	get_node("KinematicBody_000/AnimationPlayer").play("Nod")


func _on_Button_Q_pressed():
	get_node("KinematicBody_000/AnimationPlayer").play("Question_L")


func _on_Button_A_pressed():
	get_node("KinematicBody_000/AnimationPlayer").play("Question_R")


func _on_Button_F_pressed():
	get_node("KinematicBody_000/AnimationPlayer").play("Fall_Down")


func _on_Button_W_pressed():
	get_node("KinematicBody_000/AnimationPlayer").play("Walk")
	Walk_Flag = 0
	speed = Walk_speed


func _on_Button_E_pressed():
	get_node("KinematicBody_000/AnimationPlayer").play("Walk_1")
	Walk_Flag = 1
	speed = Walk_speed


func _on_Button_R_pressed():
	get_node("KinematicBody_000/AnimationPlayer").play("Run")
	Walk_Flag = 2
	speed = Run_speed


func _on_Button_J_pressed():
	get_node("KinematicBody_000/AnimationPlayer").play("Jump")


func _on_Button_S_pressed():
	get_node("KinematicBody_000/AnimationPlayer").play("Stop")
	direction = Vector3(0, 0, 0)


func _on_Button_0_pressed():
	Texture_No = Texture_No + 1
	if Texture_No >= Cube_Data:
		Texture_No = 0
	player_move()


func _on_Button_UP_pressed():
	direction.z -= 1
	direction.x = 0
	player_move()


func _on_Button_LEFT_pressed():
	direction.x -= 1
	direction.z = 0
	player_move()


func _on_Button_RIGHT_pressed():
	direction.x += 1
	direction.z = 0
	player_move()


func _on_Button_DOWN_pressed():
	direction.z += 1
	direction.x = 0
	player_move()
