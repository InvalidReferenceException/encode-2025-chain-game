// ✅ Updated system: craft_tile.cairo
#[starknet::interface]
trait ICraftTile<T> {
    fn craft(self: @T, tile_id: u64);
}

#[starknet::contract]
mod craft_tile {
    use super::*;

    #[abi(embed_v0)]
    impl ICraftTile<ContractState> for ContractState {
        fn craft(self: @ContractState, tile_id: u64) {
            let world = self.world();
            let caller = get_caller_address().into();

            let mut tile: Tile = world.get(tile_id);
            assert(tile.owner == caller, 'Not the owner');

            tile.price += 100;
            world.set(tile);
        }
    }
}