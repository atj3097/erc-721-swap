## NFT Swap Contract
Two people want to trade their NFTs in a trustless way. A user creates a swap on the contract, which is a pair of address, ids where the address is the smart contract address of the NFT and the id is the tokenId of the NFT. One person can deposit an NFT only if the id matches the address and id. The counterparty can deposit only if their NFT matches the address and id of the swap.


Once both are deposited, either party can call swap.


Some corner cases to think about:

how long, if at all, should the traders be forced to keep their NFT in the contract?

## Documentation

https://book.getfoundry.sh/

NFT one on Optimism - https://goerli-optimism.etherscan.io/address/0x2eff4b88cfa00180409a5cf2f248cbf6af4e22d6
NFT two on Optimism - https://goerli-optimism.etherscan.io/address/0x2571e123f9fff7b95a4290ffa25112f7f125822d
NFT Swap contract on Optimism - https://goerli-optimism.etherscan.io/address/0xa58ef0bbe8da13006740767f3a6104fc7f46a978
## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
