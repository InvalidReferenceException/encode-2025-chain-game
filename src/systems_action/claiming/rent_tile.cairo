
#[starknet::interface]
trait IRentTile<T> {
    fn rent(self: @T, tile_id: u64);
}

#[starknet::contract]
mod rent_tile {
    use super::*;

    #[abi(embed_v0)]
    impl IRentTile<ContractState> for ContractState {
        fn rent(self: @ContractState, tile_id: u64) {
            let world = self.world();
            let renter = get_caller_address().into();

            let tile: Tile = world.get(tile_id);
            let mut player: Player = world.get(renter);

            assert(tile.owner != 0, 'Tile unowned');
            assert(tile.owner != renter, 'Already owner');
            assert(player.wallet_balance >= 50, 'Insufficient balance');

            player.wallet_balance -= 50;
            world.set(player);
        }
    }
}
