@tool
extends CSGTorus3D



var bone_data

@export var bone_name : String
@export var get_bone_id : int
@export var Bone_ID : int


# Called when the node enters the scene tree for the first time.
func _ready():
	#var bone_data = get_node()
	bone_data = get_parent().get_parent().get_parent().get_parent()
	print("bone_data: ", bone_data)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_bone_id = bone_data.find_bone(bone_name)
	_get_Bone_data_and_assign_to_target(Bone_ID)





func _get_Bone_data_and_assign_to_target(target_bone_ID):

	#var bone_data = get_node()
	var main_bone_data = bone_data.get_bone_global_pose(target_bone_ID)
	var bone_global_transform_data = bone_data.global_pose_to_world_transform(main_bone_data)
	#var object_path_to_string = get_node(Object_to_adjust)
	#object_path_to_string.set_global_transform(bone_global_transform_data)
	set_global_transform(bone_global_transform_data)
