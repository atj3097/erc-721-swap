// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/NFTOne.sol";
import "../src/NFTTwo.sol";
import "../src/NFTSwap.sol";

contract DeployScript is Script {
    function run() public {
        vm.startBroadcast();

        // Deploy NFTOne and NFTTwo
        NFTOne nftOne = new NFTOne();
        NFTTwo nftTwo = new NFTTwo();

        // Deploy NFTSwap
        NFTSwap nftSwap = new NFTSwap();

        vm.stopBroadcast();
    }
}
