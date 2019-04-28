draw_text(10, 10, "image_angle: " + string(inst_tank.image_angle));
draw_text(10, 30, "dest_image_angle: " + string(inst_tank.dest_image_angle));

for (var i = 0; i < ds_list_size(inst_tank.cmd_queue); i++)
{
	draw_text(10, 50 + i * 15, ds_list_find_value(inst_tank.cmd_queue, i));
}

