#[derive(Copy, Drop)]
enum TileType {
    Normal = 0,
    Void = 1,
}

#[component]
struct Tile {
    #[key]
    x: u32,
    #[key]
    y: u32,

    owner: Option<ContractAddress>, // Owner or null for unclaimed tiles
    tile_type: TileType,            // Normal / Void

    cost_to_rent: u64,              // If Normal tile

    // Asset links (Frontend sends this via API)
    img_url: felt252,               // Cloud image texture URL
    model_url: felt252,             // 3D model (GLTF/GLB) URL
    description: felt252,           // Short name: "grass", "tree", "house"
    model_type: felt252,             // Model type or format (e.g., glb/gltf)
    material: felt252,               // Material data or name
}
