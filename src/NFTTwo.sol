// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NFTTwo is ERC721URIStorage {
    constructor() ERC721("GameItemTwo", "ITM2") {}

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
        _setTokenURI(tokenId, "Your token URI here");
    }
}