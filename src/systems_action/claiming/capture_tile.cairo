use dojo::world::IWorldDispatcher;
use dojo::world::world_dispatcher::WorldDispatcherTrait;
use starknet::get_caller_address;

use dojo_starter::components::tile::Tile;
use dojo_starter::components::player::Player;

#[starknet::interface]
trait ICaptureTile<T> {
    fn buy_tile(self: @T, tile_id: u64);
}

#[starknet::contract]
mod capture_tile {
    use super::*;

    #[abi(embed_v0)]
    impl ICaptureTile<ContractState> for ContractState {
        fn buy_tile(self: @ContractState, tile_id: u64) {
            let world = self.world();
            let caller = get_caller_address().into();

            let mut tile: Tile = world.get(tile_id);
            let mut player: Player = world.get(caller);

            assert(tile.owner == 0, 'Tile already owned');
            assert(player.wallet_balance >= tile.price, 'Not enough funds');

            tile.owner = caller;
            player.wallet_balance -= tile.price;
            player.tile_id = tile_id;

            world.set(tile);
            world.set(player);
        }
    }
}

