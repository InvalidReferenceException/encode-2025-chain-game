#[system]
fn get_world_map(width: u32, height: u32) -> Vec<Tile> {
    // Create an empty list to store all tiles in the map
    let mut world_tiles = Vec::new();

    // Loop through all x positions from 0 to width
    for x in 0..width {
        // Loop through all y positions from 0 to height
        for y in 0..height {
            // Check if a tile exists at position (x, y)
            if let Some(tile) = world.get::<Tile>((x, y)) {
                // If tile exists, add it to the result list
                world_tiles.push(tile);
            }
        }
    }

    // Return the full list of tiles found in the world area
    world_tiles
}