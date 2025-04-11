#[system]
fn craft_tile(player: Player, x: u32, y: u32, tile_type: felt252) {
    // Check if tile already exists at this coordinate
    if world.get::<Tile>((x, y)).is_some() {
        return; // Tile already created — prevent overwrite
    }

    // Define the resource cost (can change based on tile type)
    let required_resources: u64 = 100;

    // Check if player has enough balance
    if player.wallet_balance < required_resources {
        return; // Not enough resources to craft
    }

    // Deduct resources from player wallet (you must write this change to storage)
    let new_balance = player.wallet_balance - required_resources;
    world.set::<Player>(player.address, Player {
        wallet_balance: new_balance,
        ..player
    });

    // 5. Create the new tile and store it in the world
    world.set::<Tile>((x, y), Tile {
        x,
        y,
        owner: Some(player.address),
        tile_type,
        cost_to_rent: 10,
        img_url: 0,      // *TO DO: Replace with actual image ID or reference
        model_url: 0,    // *TO DO: Replace with model data
        texture: 0,
        description: 0,
        model_type: 0,
        material: 0,
    });
}
