// This file defines the Player component for the game world in Dojo (StarkNet)

// Player component
#[component]
struct player {
    #[key]
    address: ContractAddress,    // Unique player ID on StarkNet (primary key)
    identity: felt252,           // Player's identity (e.g., avatar type, role, or class)
    tile_id: u32,

    // Player's financial state
    wallet_balance: u64,         // Current balance or token holdings of the player 
    total_rent_earned: u64,      // Total income the player has earned (e.g., from renting land/assets)

    // Player's location / Index on the game map - To define close to normla or void tiles
    current_x: u32,              // Current X-coordinate position of the player
    current_y: u32,              // Current Y-coordinate position of the player
}
