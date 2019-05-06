if (ds_list_size(GAMEPAD_QUEUE) > 0)
{
	if (turn == turn_enum.PLAYER_TURN)
	{
		if (phase == phase_enum.PLAYER_SELECT)
		{	
			current_pad_id = ds_list_find_value(GAMEPAD_QUEUE, irandom_range(0, ds_list_size(GAMEPAD_QUEUE) - 1));
			phase = phase_enum.COMMAND_INPUT;
		}
		else if (phase == phase_enum.COMMAND_INPUT)
		{
			if (gamepad_button_check_pressed(current_pad_id, gp_padu))
			{
				ds_list_add(inst_tank.COMMAND_QUEUE, cmd_queue_enum.MOVE_FORWARD);
			}
			else if (gamepad_button_check_pressed(current_pad_id, gp_padd))
			{
				ds_list_add(inst_tank.COMMAND_QUEUE, cmd_queue_enum.MOVE_BACKWARD);
			}
			else if (gamepad_button_check_pressed(current_pad_id, gp_padl))
			{
				ds_list_add(inst_tank.COMMAND_QUEUE, cmd_queue_enum.TURN_LEFT);
			}
			else if (gamepad_button_check_pressed(current_pad_id, gp_padr))
			{
				ds_list_add(inst_tank.COMMAND_QUEUE, cmd_queue_enum.TURN_RIGHT);
			}
			else if (gamepad_button_check_pressed(current_pad_id, gp_face3))
			{
				ds_list_add(inst_tank.COMMAND_QUEUE, cmd_queue_enum.TURRET_LEFT);
			}
			else if (gamepad_button_check_pressed(current_pad_id, gp_face2))
			{
				ds_list_add(inst_tank.COMMAND_QUEUE, cmd_queue_enum.TURRET_RIGHT);
			}
			else if (gamepad_button_check_pressed(current_pad_id, gp_face4))
			{
				ds_list_add(inst_tank.COMMAND_QUEUE, cmd_queue_enum.TURRET_FIRE);
			}
			else if (gamepad_button_check_pressed(current_pad_id, gp_face1))
			{
				ds_list_clear(COMMAND_VALIDATE_QUEUE);
				var validate_count = ds_list_size(inst_tank.COMMAND_QUEUE) * 4;
				for (var i = 0; i < validate_count; i++)
				{
					ds_list_add(COMMAND_VALIDATE_QUEUE, [choose(validate_enum.UP, validate_enum.DOWN, validate_enum.LEFT, validate_enum.RIGHT), ds_list_find_value(GAMEPAD_QUEUE, irandom_range(0, ds_list_size(GAMEPAD_QUEUE) - 1))]);
				}
				
				validate_queue_idx = 0;
				phase = phase_enum.COMMAND_VALIDATE;
				alarm_set(0, VALIDATE_FRAMES);
			}
		}
		else if (phase == phase_enum.COMMAND_VALIDATE)
		{
			var validate_item = ds_list_find_value(COMMAND_VALIDATE_QUEUE, validate_queue_idx);
			
			switch(validate_item[0])
			{
				case validate_enum.UP:
					inst_arrow.image_index = 1; break;
				case validate_enum.DOWN:
					inst_arrow.image_index = 2; break;
				case validate_enum.LEFT:
					inst_arrow.image_index = 3; break;
				case validate_enum.RIGHT:
					inst_arrow.image_index = 4; break;
			}
			
			current_pad_id = validate_item[1];
		}
	}
}

if (phase == phase_enum.END)
{
	phase = phase_enum.PLAYER_SELECT;
}