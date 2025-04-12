#[system]
fn craft_tile(player: Player, x: u32, y: u32, tile_type: felt252) {
    // Check if tile already exists at this coordinate
    let existing_tile_opt = world.get::<Tile>((x, y));

    match existing_tile_opt {
        Option::Some(_) => {
            // Tile already exists at (x, y)
            return;
        },
        Option::None => {
            // Continue to create tile
        }
    }

    // Define the resource cost (can change based on tile type)
    let required_resources: u64 = 100;

    // Check if player has enough balance
    if player.wallet_balance < required_resources {
        return;
    }

    // Deduct resources from player wallet (you must write this change to storage)
    let new_balance = player.wallet_balance - required_resources;

    world.set::<Player>(player.address, Player {
        wallet_balance: new_balance,
        ..player
    });

    // Create the new tile at this x,y location
    world.set::<Tile>((x, y), Tile {
        x,
        y,
        owner: Some(player.address),
        tile_type,
        cost_to_rent: 10,

        // populate these through update or API call in Frontend
        img_url: 0,
        model_url: 0,
        texture: 0,
        description: 0,
        model_type: 0,
        material: 0,
    });
}
