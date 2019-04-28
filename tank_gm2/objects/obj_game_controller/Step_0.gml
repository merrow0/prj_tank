if (ds_list_size(GAMEPAD_QUEUE) > 0)
{
	if (is_player_turn && inst_tank.execute_cmd_queue == false)
	{
		var pad_id = ds_list_find_value(GAMEPAD_QUEUE, 0);
	
		if (gamepad_button_check_pressed(pad_id, gp_padu))
		{
			ds_list_add(inst_tank.cmd_queue, cmd_queue_enum.MOVE_FORWARD);
		}
		else if (gamepad_button_check_pressed(pad_id, gp_padd))
		{
			ds_list_add(inst_tank.cmd_queue, cmd_queue_enum.MOVE_BACKWARD);
		}
		else if (gamepad_button_check_pressed(pad_id, gp_padl))
		{
			ds_list_add(inst_tank.cmd_queue, cmd_queue_enum.TURN_LEFT);
		}
		else if (gamepad_button_check_pressed(pad_id, gp_padr))
		{
			ds_list_add(inst_tank.cmd_queue, cmd_queue_enum.TURN_RIGHT);
		}
		else if (gamepad_button_check_pressed(pad_id, gp_face3))
		{
			ds_list_add(inst_tank.cmd_queue, cmd_queue_enum.TURRET_LEFT);
		}
		else if (gamepad_button_check_pressed(pad_id, gp_face2))
		{
			ds_list_add(inst_tank.cmd_queue, cmd_queue_enum.TURRET_RIGHT);
		}
		else if (gamepad_button_check_pressed(pad_id, gp_face4))
		{
			ds_list_add(inst_tank.cmd_queue, cmd_queue_enum.TURRET_FIRE);
		}
		else if (gamepad_button_check_pressed(pad_id, gp_face1))
		{
			inst_tank.execute_cmd_queue = true;
		}
	}
}