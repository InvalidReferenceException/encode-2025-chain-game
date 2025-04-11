// Define a system that captures adjacent tiles owned by other players
#[system]
fn capture_adjacent_tiles(player: Player, x: u32, y: u32) {
    // Define the 4 cardinal directions (up, down, right, left) relative to current tile
    let directions: Array<(i32, i32)> = array![(0, 1), (0, -1), (1, 0), (-1, 0)];

    // Initialize a counter for how much rent will be gained by the player after capture
    let mut updated_rent_gain: u64 = 0;

    // Loop through each direction to check surrounding tiles
    for (dx, dy) in directions {
        // Calculate neighbor's x-coordinate by applying offset (can go negative, so i32)
        let nx = (x as i32 + dx) as u32;
        // Calculate neighbor's y-coordinate
        let ny = (y as i32 + dy) as u32;

        // Attempt to get the Tile at the (nx, ny) location
        if let Some(mut neighbor_tile) = world.get::<Tile>((nx, ny)) {

            // If the tile has an owner
            if let Some(owner) = neighbor_tile.owner {

                // And the owner is not the current player
                if owner != player.address {
                    // 1. Transfer ownership to current player
                    neighbor_tile.owner = Some(player.address);

                    // 2. Deduct rent from the previous owner's earnings
                    if let Some(mut previous_owner) = world.get::<Player>(owner) {
                        // If previous owner has enough rent to deduct
                        if previous_owner.total_rent_earned >= neighbor_tile.cost_to_rent {
                            // Subtract the tile's rent from previous owner's earnings
                            previous_owner.total_rent_earned -= neighbor_tile.cost_to_rent;
                        } else {
                            // If not enough, reset to 0
                            previous_owner.total_rent_earned = 0;
                        }

                        // Save the updated previous owner back to storage
                        world.set::<Player>(owner, previous_owner);
                    }

                    // 3. Add the rent value of the captured tile to the capturing player’s gain
                    updated_rent_gain += neighbor_tile.cost_to_rent;

                    // 4. Save the tile with updated owner info
                    world.set::<Tile>((nx, ny), neighbor_tile);
                }
            }
        }
    }

    // 5. After looping all neighbors, update the capturing player’s total rent earned
    let updated_player = Player {
        total_rent_earned: player.total_rent_earned + updated_rent_gain,
        ..player // keep the rest of the fields unchanged
    };

    // Save the updated player back into the world
    world.set::<Player>(player.address, updated_player);
}
