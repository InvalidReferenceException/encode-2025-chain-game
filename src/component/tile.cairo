#[component]
struct tile {
    #[key]
    x: u32,                          // X-coordinate of the tile
    #[key]
    y: u32,                          // Y-coordinate of the tile

    owner: Option<ContractAddress>,  // Address of the tile's owner
    tile_type: felt252,              // Type of tile: e.g., normal, void
    cost_to_rent: u64,               // Token cost to rent or move through the tile

    rented: bool,                    // Indicates whether the tile is currently being rented

    img_url: felt252,                // Cloud image asset (for AI or preview)
    model_url: felt252,              // Cloud 3D model asset (for rendering)
    texture: felt252,                // Texture or material name
    description: felt252,            // Textual description or category
    model_type: felt252,             // Model type or format (e.g., glb/gltf)
    material: felt252,               // Material data or name
}
