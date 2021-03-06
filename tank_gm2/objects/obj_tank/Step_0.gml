event_inherited();

inst_turret.x = x;
inst_turret.y = y;

if (current_state == state_enum.TURN)
{
	if (cmd == cmd_queue_enum.TURN_LEFT)
	{
		inst_turret.image_angle += 1;
	}
	else
	{
		inst_turret.image_angle -= 1;
	}
	
	dest_turret_angle = inst_turret.image_angle;
}
else if (current_state == state_enum.TURRET_TURN)
{	
	if (cmd == cmd_queue_enum.TURRET_LEFT && dest_turret_angle == inst_turret.image_angle)
	{
		dest_turret_angle = inst_turret.image_angle + 90;
	}
	else if (cmd == cmd_queue_enum.TURRET_RIGHT && dest_turret_angle == inst_turret.image_angle)
	{
		dest_turret_angle = inst_turret.image_angle - 90;
	}
	
	if (dest_turret_angle != inst_turret.image_angle)
	{
		if (dest_turret_angle > inst_turret.image_angle)
		{
			inst_turret.image_angle += 1;
		}
		else
		{
			inst_turret.image_angle -= 1;
		}	
	}
	
	
	if (dest_turret_angle == inst_turret.image_angle)
	{
		current_state = state_enum.INIT;
	}
}