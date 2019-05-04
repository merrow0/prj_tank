enum state_enum {
	NONE,
	INIT,
	MOVE,
	TURN,
	TURRET_TURN,
	TURRET_SHOOT
}

COMMAND_QUEUE = ds_list_create();
cmd = noone;
current_state = state_enum.NONE;
move_path = path_add();
dest_image_angle = image_angle;