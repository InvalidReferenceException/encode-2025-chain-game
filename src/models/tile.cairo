use starknet::ContractAddress;
use core::option::Option;

#[derive(Copy, Drop, Serde)]
#[dojo::model::Model]
pub struct Tile {
    #[key]
    pub tile_id: u64,
    pub owner: Option<ContractAddress>,
    pub price: u64,
    pub level: u8,
}
