@tool #activates the tool function
extends Skeleton3D


#Exports the "IK Script Active" Button into the Editor inspector
@export_enum("IK Tools Active", "IK Tools Inactive") var IK_Script_Active = 1

@export_flags("Reset_now") var Reset_xy = 0




# Called when the node enters the scene tree for the first time.
func _ready():
	#_set_Body_Main_Bone_ALL_loc_rot_scale_data()
	
	#_setup_max_bone_axial_rot() #testrun
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
# _ready() gets called first and with it the _get_Body_Main_Bone_ALL_loc_rot_scale_data() function
#after that the Body_Main_Bone_ALL in the 3d editor will change the position to the main_bone "spine"(Bone Nr.0)
func _process(delta) -> void:
	if IK_Script_Active == 1: return
	
	if Reset_xy == 1: _setup_max_bone_axial_rot(delta); Reset_xy = 0
	
	if IK_Script_Active == 0:
		_get_Body_Main_Bone_ALL_loc_rot_scale_data()
		
		
	else: pass




func _setup_max_bone_axial_rot(_delta): 
	#var test_local_pos_data = global_pose_to_world_transform(get_bone_global_pose(57)) 
	
	
	var test_local_pos_data = get_bone_global_pose(57)
	print("test_local_pos_data: ", test_local_pos_data)








func _get_Body_Main_Bone_ALL_loc_rot_scale_data():
	
	var get_tool_for_spine_zero = $IK_Targets/Total_Upper_Body/Body_Main_Bone_ALL.get_global_transform()
	var make_it_local_for_pose = world_transform_to_global_pose(get_tool_for_spine_zero)
	set_bone_global_pose_override(0, make_it_local_for_pose, 1, true)
	



#gets the Base Bone position, rotation, scale, and get the global data out of it, and use these datas for the Body_Main_Bone_All tool in the 3d editor
#the data has to match in the beginning, or else the player pose will look deformed at the start
#make sure to activate the "IK_Script_Active" option before you start to work with the tool
func _set_Body_Main_Bone_ALL_loc_rot_scale_data():
	var main_bone_data = get_bone_global_pose(0)
	var g_transform = global_pose_to_world_transform(main_bone_data)
	print("main_bone_data: ", main_bone_data)
	$IK_Targets/Total_Upper_Body/Body_Main_Bone_ALL.set_global_transform(g_transform)


