use starknet::ContractAddress;


#[derive(Copy, Drop, Serde)]
#[dojo::model::Model]
pub struct Player {
    #[key]
    pub address: ContractAddress,
    pub wallet_balance: u64,
    pub identity: u64,
    pub tile_id: u64,
}
