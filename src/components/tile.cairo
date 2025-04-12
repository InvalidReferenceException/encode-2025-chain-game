use starknet::ContractAddress;

// Constants for tile types
pub const TILE_TYPE_NORMAL: u8 = 0;
pub const TILE_TYPE_VOID: u8 = 1;

#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Tile {
    #[key]
    pub x: u32,
    #[key]
    pub y: u32,
    pub owner: ContractAddress,
    pub tile_type: u8,
    pub rent_cost: u128
}