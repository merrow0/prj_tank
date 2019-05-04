globalvar enum cmd_queue_enum {
	MOVE_FORWARD,
	MOVE_BACKWARD,
	TURN_LEFT,
	TURN_RIGHT,
	TURRET_LEFT,
	TURRET_RIGHT,
	TURRET_FIRE
};

globalvar enum phase_enum {
	PLAYER_SELECT,
	COMMAND_INPUT,
	COMMAND_VALIDATE,
	COMMAND_EXECUTE,
	END
};

globalvar enum turn_enum {
	PLAYER_TURN,
	ENEMY_TURN
};

globalvar enum validate_enum {
	UP,
	DOWN,
	LEFT,
	RIGHT
}


TILE_WIDTH = 64;
TILE_HEIGHT = 64;
GRID_WIDTH = room_width div TILE_WIDTH;
GRID_HEIGHT =  room_height div TILE_HEIGHT;
VALIDATE_FRAMES = 60;
GAMEPAD_QUEUE = ds_list_create();
COMMAND_VALIDATE_QUEUE = ds_list_create();

turn = turn_enum.PLAYER_TURN;
phase = phase_enum.COMMAND_INPUT;
validate_queue_idx = 0;

grid = mp_grid_create(0, 0, GRID_WIDTH , GRID_HEIGHT, TILE_WIDTH, TILE_HEIGHT);

var maxpads = gamepad_get_device_count();
for (var i = 0; i < maxpads; i++)
{
	if (gamepad_is_connected(i))
    {
		ds_list_add(GAMEPAD_QUEUE, i);
    }
}

ds_list_add(GAMEPAD_QUEUE, 4);

inst_tank = instance_create_layer(5*TILE_WIDTH, 5*TILE_HEIGHT, "hull", obj_tank);
inst_arrow = instance_create_layer(room_width div 2, room_height / 2, "top", obj_arrow);