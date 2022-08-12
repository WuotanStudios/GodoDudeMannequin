@tool
extends CSGTorus3D

@export_enum("IK Tools Inactive", "IK Tools Active") var IK_Script_Active = 1
var rotate_y : float = 0.0


func _process(delta):
	var temp_rotation = get_rotation()
	rotate_y = temp_rotation.y
	
	if IK_Script_Active == 1:
		
		var rotate_x = 0
		var rotate_z = 0
		
		
		set_rotation(Vector3(rotate_x, rotate_y, rotate_z))
		set_position(Vector3(0,0,0))
	else: pass
