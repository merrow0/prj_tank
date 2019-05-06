with (obj_game_controller)
{
	if (turn == turn_enum.PLAYER_TURN)
	{
		other.image_index = ds_list_find_index(GAMEPAD_QUEUE, current_pad_id);
	}
}