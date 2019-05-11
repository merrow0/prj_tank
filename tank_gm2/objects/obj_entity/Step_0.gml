if (obj_game_controller.phase == phase_enum.COMMAND_EXECUTE && current_state == state_enum.NONE)
{
	current_state = state_enum.INIT;
}

if (current_state == state_enum.INIT)
{
	if (ds_list_size(COMMAND_QUEUE) > 0)
	{
		cmd = ds_list_find_value(COMMAND_QUEUE, 0);
		ds_list_delete(COMMAND_QUEUE, 0);
		
		if (cmd == cmd_queue_enum.MOVE_FORWARD || cmd == cmd_queue_enum.MOVE_BACKWARD)
		{
			current_state = state_enum.MOVE;
		}
		else if (cmd == cmd_queue_enum.TURN_LEFT || cmd == cmd_queue_enum.TURN_RIGHT)
		{
			current_state = state_enum.TURN;
		}
		else if (cmd == cmd_queue_enum.TURRET_LEFT || cmd == cmd_queue_enum.TURRET_RIGHT)
		{
			current_state = state_enum.TURRET_TURN;
		}
	}
	else
	{
		obj_game_controller.phase = phase_enum.END;
		current_state = state_enum.NONE;
	}
}


if (current_state == state_enum.MOVE)
{
	if (path_position == 0)
	{
		var off_x = 0;
		var off_y = 0;
		
		if (image_angle % 360 == 0)
		{
			off_x = obj_game_controller.TILE_WIDTH;
			off_y = 0;
		}
		else if (abs(image_angle % 360) == 90)
		{
			off_x = 0;
			off_y = -obj_game_controller.TILE_HEIGHT * sign(image_angle);
		}
		else if (abs(image_angle % 360) == 180)
		{
			off_x = -obj_game_controller.TILE_WIDTH;
			off_y = 0;
		}
		else if (abs(image_angle % 360) == 270)
		{
			off_x = 0;
			off_y = obj_game_controller.TILE_HEIGHT * sign(image_angle);
		}
		
		
		if (cmd == cmd_queue_enum.MOVE_BACKWARD)
		{
			off_x *= -1;
			off_y *= -1;
		}
		
		
		if (mp_grid_path(obj_game_controller.path_grid, move_path, x, y, x + off_x, y + off_y, false))
		{
			path_start(move_path, 1, path_action_stop, false);
		}
		else
		{
			path_position = 1;
		}	
	}
	
	if (path_position == 1)
	{
		path_end();
		path_position = 0;
		current_state = state_enum.INIT;
	}
}
else if (current_state == state_enum.TURN)
{
	if (cmd == cmd_queue_enum.TURN_LEFT && dest_image_angle == image_angle)
	{		
		dest_image_angle = image_angle + 90;
	}
	else if (cmd == cmd_queue_enum.TURN_RIGHT && dest_image_angle == image_angle)
	{	
		dest_image_angle = image_angle - 90;
	}
	
	if (image_angle != dest_image_angle)
	{
		if (dest_image_angle > image_angle)
		{
			image_angle += 1;
		}
		else
		{
			image_angle -= 1;
		}	
	}
}


