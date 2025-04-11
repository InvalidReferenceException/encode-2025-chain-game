#[system]
fn rent_nearby_tiles_with_payment(mut player: Player, radius: u32) -> Vec<Tile> {
    // Get the player's current position
    let center_x = player.tile1;
    let center_y = player.current_y;

    // This will collect the tiles within the radius
    let mut tiles = Vec::new();

    // Loop through the square area around the player (based on the radius)
    for dx in -radius..=radius {
        for dy in -radius..=radius {
            let x = center_x + dx;
            let y = center_y + dy;

            // Get tile at (x, y), if it exists
            if let Some(mut tile) = world.get::<Tile>((x, y)) {
                // Only rent if tile has an owner and is not already rented
                if let Some(owner) = tile.owner {
                    if !tile.rented {
                        // Ensure the player has enough tokens to pay rent
                        if player.wallet_balance >= tile.cost_to_rent {
                            // Deduct rent from the player's balance
                            player.wallet_balance -= tile.cost_to_rent;

                            // Pay the rent to the tile's owner
                            if let Some(mut owner_data) = world.get::<Player>(owner) {
                                owner_data.wallet_balance += tile.cost_to_rent;
                                owner_data.total_rent_earned += tile.cost_to_rent;

                                // Save updated owner info
                                world.set::<Player>(owner, owner_data);
                            }

                            // Mark tile as currently rented
                            tile.rented = true;
                            world.set::<Tile>((x, y), tile);
                        }
                        // Else: player doesn't have enough balance, skip
                    }
                    // Else: tile already rented, skip
                }
                // Add tile to result whether rented or not
                tiles.push(tile);
            }
        }
    }

    // Save updated player data after deducting rent
    world.set::<Player>(player.address, player);

    // Return all nearby tiles (with or without rent applied)
    tiles
}
