enum state {
	NONE,
	INIT,
	MOVE,
	TURN,
	TURRET_TURN,
	TURRET_SHOOT
}

cmd_queue = ds_list_create();
execute_cmd_queue = false;
cmd = noone;
current_state = state.NONE;
move_path = path_add();
dest_image_angle = image_angle;