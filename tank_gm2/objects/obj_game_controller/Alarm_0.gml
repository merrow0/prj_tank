if (phase == phase_enum.COMMAND_VALIDATE)
{
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