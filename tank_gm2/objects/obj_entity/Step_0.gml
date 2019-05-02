if (execute_cmd_queue && current_state == state.NONE)
{
	current_state = state.INIT;
}

if (current_state == state.INIT)
{
	if (ds_list_size(cmd_queue) > 0)
	{
		cmd = ds_list_find_value(cmd_queue, 0);
		ds_list_delete(cmd_queue, 0);
		
		if (cmd == cmd_queue_enum.MOVE_FORWARD || cmd == cmd_queue_enum.MOVE_BACKWARD)
		{
			current_state = state.MOVE;
		}
		else if (cmd == cmd_queue_enum.TURN_LEFT || cmd == cmd_queue_enum.TURN_RIGHT)
		{
			current_state = state.TURN;
		}
		else if (cmd == cmd_queue_enum.TURRET_LEFT || cmd == cmd_queue_enum.TURRET_RIGHT)
		{
			current_state = state.TURRET_TURN;
		}
	}
	else
	{
		execute_cmd_queue = false;
		current_state = state.NONE;
	}
}


if (current_state == state.MOVE)
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
		
		
		if (mp_grid_path(obj_game_controller.grid, move_path, x, y, x + off_x, y + off_y, false))
		{
			path_start(move_path, 1, path_action_stop, false);
		}
	}
	else if (path_position == 1)
	{
		path_end();
		path_position = 0;
		current_state = state.INIT;
	}
}
else if (current_state == state.TURN)
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


