// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "../src/NFTSwap.sol";
import "../src/NFTOne.sol";
import "../src/NFTTwo.sol";
import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract NFTSwapTest is DSTest {
    NFTSwap nftSwap;
    NFTOne nftOne;
    NFTTwo nftTwo;
    address party1;
    address party2;

    struct Swap {
        address nftAddress1;
        uint256 tokenId1;
        address nftAddress2;
        uint256 tokenId2;
        address party1;
        address party2;
        uint256 creationTime;
    }

    function setUp() public {
        nftOne = new NFTOne();
        nftTwo = new NFTTwo();
        nftSwap = new NFTSwap();
        party1 = address(0x1);
        party2 = address(0x2);

        nftOne.mint(party1, 1);
        nftTwo.mint(party2, 2);
    }

    function testCreateSwap() public {
        nftSwap.createSwap(address(nftOne), 1, address(nftTwo), 2, party1, party2);
        Swap memory swap = nftSwap.swaps(0);
        assertEq(swap.nftAddress1, address(nftOne));
        assertEq(swap.tokenId1, 1);
        assertEq(swap.nftAddress2, address(nftTwo));
        assertEq(swap.tokenId2, 2);
        assertEq(swap.party1, party1);
        assertEq(swap.party2, party2);
    }

    function testDepositNft() public {
        nftSwap.createSwap(address(nftOne), 1, address(nftTwo), 2, party1, party2);
        nftSwap.depositNft(0, address(nftOne));
        nftSwap.depositNft(0, address(nftTwo));
        assertEq(nftSwap.deposited(party1), true);
        assertEq(nftSwap.deposited(party2), true);
    }
}
