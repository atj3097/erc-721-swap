// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract NFTOne is ERC721URIStorage {
    constructor() ERC721("GameItemOne", "ITM1") {}
}