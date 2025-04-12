use starknet::ContractAddress;
// This file defines the Player component for the game world in Dojo (StarkNet)

// player component
#[component]
struct player {
    #[key]
    address: ContractAddress,    // Unique player ID on StarkNet (primary key)
    identity: felt252,           // Player's identity (e.g., avatar type, role, or class)
    tile_id: u32,
    tilesOwned: u32,
    arrayoftile: Vec<Tile>

    // Player's financial state
    wallet_balance: u64,         // Current balance or token holdings of the player 
    total_rent_earned: u64,      // Total income the player has earned (e.g., from renting land/assets)

    // Player's location on the game map - To define close to normal or void tiles
    current_tile = felt252              // Current Y-coordinate position of the player
}
