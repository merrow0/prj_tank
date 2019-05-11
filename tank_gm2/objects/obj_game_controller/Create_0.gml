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

globalvar enum tile_type_enum {
	VOID,
	WALL,
	FLOOR
}

TILE_WIDTH = 64;
TILE_HEIGHT = 64;
GRID_WIDTH = room_width div TILE_WIDTH;
GRID_HEIGHT =  room_height div TILE_HEIGHT;
VALIDATE_FRAMES = 60;
GAMEPAD_QUEUE = ds_list_create();
COMMAND_VALIDATE_QUEUE = ds_list_create();
COMMAND_INPUT_QUEUE = ds_list_create();

turn = turn_enum.PLAYER_TURN;
phase = phase_enum.PLAYER_SELECT;
validate_queue_idx = 0;
current_pad_id = noone;
current_validate_direction = noone;

var maxpads = gamepad_get_device_count();
for (var i = 0; i < maxpads; i++)
{
	if (gamepad_is_connected(i))
    {
		ds_list_add(GAMEPAD_QUEUE, i);
    }
}

ds_list_add(GAMEPAD_QUEUE, 4);
// ds_list_add(GAMEPAD_QUEUE, 5);
// ds_list_add(GAMEPAD_QUEUE, 6);

inst_tank = instance_create_layer((room_width div 2) + (TILE_WIDTH div 2), (room_height div 2) + (TILE_HEIGHT div 2), "hull", obj_tank);
inst_arrow = instance_create_layer(1 * TILE_WIDTH, 1 * TILE_HEIGHT, "top", obj_arrow);
inst_player = instance_create_layer(1 * TILE_WIDTH, 2 * TILE_HEIGHT, "top", obj_player);

path_grid = mp_grid_create(0, 0, GRID_WIDTH , GRID_HEIGHT, TILE_WIDTH, TILE_HEIGHT);

randomize();

// *** LEVEL GEN ***
level_grid = ds_grid_create(GRID_WIDTH, GRID_HEIGHT);
ds_grid_set_region(level_grid, 0, 0, GRID_WIDTH-1, GRID_HEIGHT-1, tile_type_enum.VOID);

var cx = GRID_WIDTH div 2;
var cy = GRID_HEIGHT div 2;

var cdir = 0;
var odds = 1;

// Wege generieren
repeat(100)
{
    level_grid[# cx, cy] = tile_type_enum.FLOOR;     // Accessor syntax
    
    if (irandom(odds) == odds)
        cdir = irandom(3);
    
    var xdir = lengthdir_x(1, cdir*90);
    var ydir = lengthdir_y(1, cdir*90);
    cx += xdir;
    cy += ydir;
    
    cx = clamp(cx, 1, GRID_WIDTH - 2);
    cy = clamp(cy, 1, GRID_HEIGHT - 2);
}

// Wände generieren
for (var yy = 1; yy < GRID_HEIGHT - 1; yy++)
{
    for (var xx = 1; xx < GRID_WIDTH - 1; xx++)
    {
        if (level_grid[# xx, yy] == tile_type_enum.FLOOR)
        {
            if (level_grid[# xx + 1, yy] != tile_type_enum.FLOOR) level_grid[# xx + 1, yy] = tile_type_enum.WALL;
            if (level_grid[# xx - 1, yy] != tile_type_enum.FLOOR) level_grid[# xx - 1, yy] = tile_type_enum.WALL;
            if (level_grid[# xx, yy + 1] != tile_type_enum.FLOOR) level_grid[# xx, yy + 1] = tile_type_enum.WALL;
            if (level_grid[# xx, yy - 1] != tile_type_enum.FLOOR) level_grid[# xx, yy - 1] = tile_type_enum.WALL;
        }
    }
}

// Einerwände säubern
for (var yy = 1; yy < GRID_HEIGHT - 1; yy++)
{
    for (var xx = 1; xx < GRID_WIDTH - 1; xx++)
    {
        if (level_grid[# xx, yy] == tile_type_enum.WALL)
        {
            if (level_grid[# xx + 1, yy] == tile_type_enum.FLOOR && level_grid[# xx - 1, yy] == tile_type_enum.FLOOR
                && level_grid[# xx, yy + 1] == tile_type_enum.FLOOR && level_grid[# xx, yy - 1] == tile_type_enum.FLOOR)
                    level_grid[# xx, yy] = tile_type_enum.FLOOR;
        }
    }
}

// Grid zeichnen
for (var yy = 0; yy < GRID_HEIGHT; yy++)
{
    for (var xx = 0; xx < GRID_WIDTH; xx++)
    {
        if (level_grid[# xx, yy] == tile_type_enum.FLOOR)
        {
			// instance_create_layer(xx, yy, "level", obj_)
            // grid_tile_add(xx, yy, bg_floor, 10);
        }
        else
        {
            if (level_grid[# xx, yy] == tile_type_enum.WALL)
                instance_create_layer(xx * TILE_WIDTH, yy * TILE_HEIGHT, "level", obj_wall);
				
            mp_grid_add_cell(path_grid, xx, yy);
        }
        
            
        //// Idee: So die Emenies so spawnen, oder über das Grid???
        //if (grid[# xx, yy] == FLOOR)
        //{
        //    var enemy_odds = 20;
        //    var ex = xx * CELL_WIDTH + CELL_WIDTH / 2;
        //    var ey = yy * CELL_HEIGHT + CELL_HEIGHT / 2;
            
        //    if (point_distance(ex, ey, obj_player.x, obj_player.y) > 150 && irandom(enemy_odds) == enemy_odds)
        //        instance_create(ex, ey, obj_enemy);
        //}
    }
}
