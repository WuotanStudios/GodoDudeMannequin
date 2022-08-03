@tool #activates the tool function
extends Skeleton3D


#Exports the "IK Script Active" Button into the Editor inspector
@export_enum("IK Tools Active", "IK Tools Inactive") var IK_Script_Active = 1

@export var bone_name : String
@export var get_bone_id : int

@export_node_path(Node3D) var Node3D_Path
@export var Bone_ID : int
@export_flags("start") var Assign_data_from_target_to_Bone = 0



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
	
	if Assign_data_from_target_to_Bone == 1: _copy_data_from_BoneID_to_target_Node3D()
	
	_use_bone_name_to_find_bone_index_nr()
	return
	
	
	if IK_Script_Active == 0:
		_get_Body_Main_Bone_ALL_loc_rot_scale_data()
		
	else: pass




func _setup_max_bone_axial_rot(_delta): 
	pass



func _get_Body_Main_Bone_ALL_loc_rot_scale_data():
	var get_tool_for_spine_zero = $IK_Targets/Total_Upper_Body/Body_Main_Bone_ALL.get_global_transform()
	var make_it_local_for_pose = world_transform_to_global_pose(get_tool_for_spine_zero)
	set_bone_global_pose_override(0, make_it_local_for_pose, 1, true)



func _use_bone_name_to_find_bone_index_nr():
	get_bone_id = find_bone(bone_name)


func _copy_data_from_BoneID_to_target_Node3D():
	if Assign_data_from_target_to_Bone == 1: 
		if Bone_ID <= 0 or Node3D_Path == null: print("Bone_ID or/and Node3d_path is missing"); Assign_data_from_target_to_Bone = 0; return
		
		else: _get_Bone_data_and_assign_to_target(Bone_ID, Node3D_Path); #Assign_data_from_target_to_Bone = 0


func _get_Bone_data_and_assign_to_target(target_bone_ID, Object_to_adjust):
	var main_bone_data = get_bone_global_pose(target_bone_ID)
	var bone_global_transform_data = global_pose_to_world_transform(main_bone_data)
	var object_path_to_string = get_node(Object_to_adjust)
	
	object_path_to_string.set_global_transform(bone_global_transform_data)
	
	Assign_data_from_target_to_Bone = 0
	
	#var make_it_local_for_pose = world_transform_to_global_pose(object_path_to_string.get_global_transform())
	#set_bone_global_pose_override(target_bone_ID, make_it_local_for_pose, 1, true)


