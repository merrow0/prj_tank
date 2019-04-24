enum state {
	NONE,
	INIT,
	MOVE,
	TURN,
	SHOOT
}

cmd_queue = ds_list_create();
execute_cmd_queue = false;
cmd = noone;
is_executing_step = false;
current_state = state.NONE;
move_path = path_add();