globalvar enum cmd_queue_enum {
	MOVE_FORWARD,
	MOVE_BACKWARD,
	TURN_LEFT,
	TURN_RIGHT,
	TURRET_LEFT,
	TURRET_RIGHT,
	TURRET_FIRE
};

TILE_WIDTH = 64;
TILE_HEIGHT = 64;
GRID_WIDTH = room_width div TILE_WIDTH;
GRID_HEIGHT =  room_height div TILE_HEIGHT;
GAMEPAD_QUEUE = ds_list_create();

is_player_turn = true;

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