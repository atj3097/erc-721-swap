// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/NFTSwap.sol";
import "../src/NFTOne.sol";
import "../src/NFTTwo.sol";
import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract NFTSwapTest is Test {
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
        (address nftAddress1, uint256 tokenId1, address nftAddress2, uint256 tokenId2, address party1, address party2, uint256 creationTime) = nftSwap.swaps(0);
        assertEq(nftAddress1, address(nftOne));
        assertEq(tokenId1, 1);
        assertEq(nftAddress2, address(nftTwo));
        assertEq(tokenId2, 2);
        assertEq(party1, party1);
        assertEq(party2, party2);
    }

    function testDepositNft() public {
        nftSwap.createSwap(address(nftOne), 1, address(nftTwo), 2, party1, party2);
        vm.prank(party1);
        nftOne.approve(address(nftSwap), 1);

        vm.prank(party2);
        nftTwo.approve(address(nftSwap), 2);

        vm.prank(party1);
        nftSwap.depositNft(0, address(nftOne));

        vm.prank(party2);
        nftSwap.depositNft(0, address(nftTwo));
        assertEq(nftSwap.deposited(party1), true);
        assertEq(nftSwap.deposited(party2), true);
    }
}
