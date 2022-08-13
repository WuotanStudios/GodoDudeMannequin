@tool #activates the tool function
extends Skeleton3D

##---------------------------------------------------------------------------------------------------##
#Exports the "IK Script Active" Button into the Editor inspector
@export_enum("IK Tools Active", "IK Tools Inactive") var IK_Script_Active = 1 
##---------------------------------------------------------------------------------------------------##

##---------------------------------------------------------------------------------------------------##
@export var bone_name : String #type the bone name in the editor inspector by selecting the Skeleton3D node first
@export var get_bone_id : int #after typing the name of the bone, the bone ID will stored in this var
##---------------------------------------------------------------------------------------------------##

##---------------------------------------------------------------------------------------------------##
# this are export variables for the function _copy_data_from_BoneID_to_target_Node3D(), see below
@export_node_path(Node3D) var Node3D_Path  
@export var Bone_ID : int
@export_flags("start") var Assign_data_from_target_to_Bone = 0
##---------------------------------------------------------------------------------------------------##



func _ready():
	pass




func _process(delta) -> void:
	if IK_Script_Active == 1: return
	
	if Assign_data_from_target_to_Bone == 1: 
		#print("Script Aktiv"); 
		_copy_data_from_BoneID_to_target_Node3D() #a little tool to adjust an object to the local bone pose
		_use_bone_name_to_find_bone_index_nr() #this is just a little tool to find a bone ID according to its bone name
		return
	
	if IK_Script_Active == 0: #in this case 0 = active
		_get_Body_Main_Bone_ALL_loc_rot_scale_data() #this function gets the main bone data (spine bone nr. 0) 
		_use_bone_name_to_find_bone_index_nr() #this is just a little tool to find a bone ID according to its bone name
		
		_get_ctrl_data()
		
		return
		
	else: pass



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



func _get_ctrl_data():
	var controller_id
	var ctrl_position_1 : Vector3
	var temp_ctrl_position_1 : Vector3 = $Attachm_LeftHand/Reposition/Left_Arm_Hand_Rot_ctrl.get_rotation()
	ctrl_position_1.x = temp_ctrl_position_1.y
	var temp_ctrl_position_2 : Vector3 = $Attachm_LeftHand/Reposition/Left_Arm_Hand_Rot_ctrl/Left_Hand_Bow_ctrl.get_position() *10
	ctrl_position_1.y = temp_ctrl_position_2.y
	ctrl_position_1.z = 0
	_set_blend2d_by_ctrl_data_left_wrist(ctrl_position_1)
	
	
	var ctrl_position_2 : Vector3
	var temp_ctrl_position_3 : Vector3 = $Attachm_RightHand/Reposition/Right_Arm_Hand_Rot_ctrl.get_rotation()
	ctrl_position_2.x = temp_ctrl_position_3.y
	var temp_ctrl_position_4 : Vector3 = $Attachm_RightHand/Reposition/Right_Arm_Hand_Rot_ctrl/Right_Hand_Bow_ctrl.get_position() *10
	ctrl_position_2.y = temp_ctrl_position_4.y
	ctrl_position_2.z = 0
	_set_blend2d_by_ctrl_data_right_wrist(ctrl_position_2)







func _set_blend2d_by_ctrl_data_left_wrist(ctrl_position : Vector3):
	$Hand_ctrl_Anim_Tree.set("parameters/left_h_rot/blend_position", ctrl_position.x)
	$Hand_ctrl_Anim_Tree.set("parameters/left_h_bow/blend_position", ctrl_position.y)


func _set_blend2d_by_ctrl_data_right_wrist(ctrl_position : Vector3):
	$Hand_ctrl_Anim_Tree.set("parameters/right_h_rot/blend_position", ctrl_position.x)
	$Hand_ctrl_Anim_Tree.set("parameters/right_h_bow/blend_position", ctrl_position.y)

