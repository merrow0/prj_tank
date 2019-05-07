if (phase == phase_enum.COMMAND_VALIDATE)
{
	var count = ds_list_size(COMMAND_INPUT_QUEUE);
	if (count > 0)
	{
		var input_item = ds_list_find_value(COMMAND_INPUT_QUEUE, 0);
		var input_direction = input_item[0];
		var input_gamepad = input_item[1];
	
		show_debug_message("YYY: " + string(input_direction) + "/" + string(input_gamepad));
	
		if (ds_list_size(COMMAND_INPUT_QUEUE) == 1 && (input_direction == current_validate_direction && input_gamepad == current_pad_id))
		{
			show_debug_message("GEIL");
		}
		else
		{
			show_debug_message("SXHERISSE, FALSCG GEMACHT");
		}
	}
	else
	{
		show_debug_message("SXHERISSE, NIX GEMACHT");
	}
	
	ds_list_clear(COMMAND_INPUT_QUEUE);
	
	if (validate_queue_idx == ds_list_size(COMMAND_VALIDATE_QUEUE) - 1)
	{
		inst_arrow.image_index = 0;
		phase = phase_enum.COMMAND_EXECUTE;
	}
	else
	{
		validate_queue_idx += 1;
		alarm_set(0, VALIDATE_FRAMES);
	}
}