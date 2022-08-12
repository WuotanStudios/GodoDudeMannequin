@tool
extends CSGBox3D



@export_enum("IK Tools Inactive", "IK Tools Active") var IK_Script_Active = 1
@export var transfrom_y : float = 0.0
@export_flags("invert position x") var invert = 0


func _process(delta):
	
	if IK_Script_Active == 1:
		var do_invert = 1
		if invert == 0: do_invert = -1
		else: do_invert = 1
		
		var transfrom_x = 0.05 * do_invert
		var transfrom_z = 0
		
		
		set_position(Vector3(transfrom_x, transfrom_y, transfrom_z))
		
	else: pass
