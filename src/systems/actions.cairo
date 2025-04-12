use dojo_starter::models::{Direction, Position};
use dojo_starter::components::player::Player;
use dojo_starter::components::tile::{Tile, TILE_TYPE_NORMAL, TILE_TYPE_VOID};
use dojo_starter::components::rent::{TileRentInfo, RentPaid};

// Define the interface
#[starknet::interface]
pub trait IActions<T> {
    // Player management
    fn spawn_player(ref self: T);
    fn move_player(ref self: T, x: u32, y: u32);

    // Tile management
    fn create_normal_tile(ref self: T, x: u32, y: u32, rent_cost: u128);
    fn collect_rent(ref self: T, x: u32, y: u32);
}

// Dojo contract implementation
#[dojo::contract]
pub mod actions {
    use super::IActions;
    use starknet::{ContractAddress, get_caller_address, get_block_timestamp};
    use dojo_starter::models::{Direction, Position, Vec2, Moves};
    use dojo_starter::components::player::Player;
    use dojo_starter::components::tile::{Tile, TILE_TYPE_NORMAL, TILE_TYPE_VOID};
    use dojo_starter::components::rent::{TileRentInfo, RentPaid};

    use dojo::model::{ModelStorage};
    use dojo::event::EventStorage;

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        // Initialize a new player
        fn spawn_player(ref self: ContractState) {
            let mut world = self.world_default();
            let player = get_caller_address();

            // Create the player
            let new_player = Player {
                player_id: player,
                tokens_balance: 1000, // Starting balance
                total_rent_earned: 0,
                position_x: 0, // Starting position
                position_y: 0
            };

            // Write to world
            world.write_model(@new_player);

            // Also create the original position model for compatibility with existing code
            let position = Position {
                player, vec: Vec2 { x: 0, y: 0 },
            };

            let moves = Moves {
                player, remaining: 100, last_direction: Option::None, can_move: true,
            };

            world.write_model(@position);
            world.write_model(@moves);
        }

        // Move player to a specific coordinate
        fn move_player(ref self: ContractState, x: u32, y: u32) {
            let mut world = self.world_default();
            let player = get_caller_address();

            // Get current player state
            let mut player_data: Player = world.read_model(player);

            // Update player position
            player_data.position_x = x;
            player_data.position_y = y;

            // Write updated player data
            world.write_model(@player_data);

            // Also update the original position model for compatibility
            let position = Position {
                player, vec: Vec2 { x, y },
            };
            world.write_model(@position);
        }

        // Create a new normal tile
        fn create_normal_tile(
            ref self: ContractState,
            x: u32,
            y: u32,
            rent_cost: u128
        ) {
            let mut world = self.world_default();
            let player = get_caller_address();

            // Create the tile
            let new_tile = Tile {
                x,
                y,
                owner: player,
                tile_type: TILE_TYPE_NORMAL,
                rent_cost
            };

            // Initialize rent tracking
            let rent_info = TileRentInfo {
                x,
                y,
                total_rent_collected: 0,
                last_rent_timestamp: 0
            };

            // Write to world
            world.write_model(@new_tile);
            world.write_model(@rent_info);
        }

        // Collect accumulated rent for a tile owner
        fn collect_rent(ref self: ContractState, x: u32, y: u32) {
            let mut world = self.world_default();
            let player = get_caller_address();

            // Get the tile to verify ownership
            let tile: Tile = world.read_model((x, y));

            // Check if caller is the owner
            if tile.owner != player {
                return; // Not the owner
            }

            // Get rent info
            let mut rent_info: TileRentInfo = world.read_model((x, y));

            // If no rent to collect, return early
            if rent_info.total_rent_collected == 0 {
                return;
            }

            // Get player data to update balance
            let mut player_data: Player = world.read_model(player);

            // Update player's balance and total rent earned
            player_data.tokens_balance += rent_info.total_rent_collected;
            player_data.total_rent_earned += rent_info.total_rent_collected;

            // Reset rent collected for the tile
            rent_info.total_rent_collected = 0;

            // Write updates to world
            world.write_model(@player_data);
            world.write_model(@rent_info);
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn world_default(self: @ContractState) -> dojo::world::WorldStorage {
            self.world(@"dojo_starter")
        }
    }
}

// Keep the existing next_position function
fn next_position(mut position: Position, direction: Option<Direction>) -> Position {
    match direction {
        Option::None => { return position; },
        Option::Some(d) => match d {
            Direction::Left => { position.vec.x -= 1; },
            Direction::Right => { position.vec.x += 1; },
            Direction::Up => { position.vec.y -= 1; },
            Direction::Down => { position.vec.y += 1; },
        },
    };
    position
}