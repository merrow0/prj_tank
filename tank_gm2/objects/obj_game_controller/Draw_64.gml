draw_text(10, 10, "image_angle: " + string(inst_tank.image_angle));
draw_text(10, 30, "dest_image_angle: " + string(inst_tank.dest_image_angle));

for (var i = 0; i < ds_list_size(inst_tank.COMMAND_QUEUE); i++)
{
	draw_text(10, 50 + i * 15, ds_list_find_value(inst_tank.COMMAND_QUEUE, i));
}

draw_text(300, 10, "validate_queue_idx: " + string(validate_queue_idx));
draw_text(300, 30, "inst_arrow.image_index: " + string(inst_arrow.image_index));

