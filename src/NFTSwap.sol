// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./NFTOne.sol";
import "./NFTTwo.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC721/utils/ERC721Holder.sol";

contract NFTSwap is ERC721Holder {

    struct Swap {
        address nftAddress1;
        uint256 tokenId1;
        address nftAddress2;
        uint256 tokenId2;
        address party1;
        address party2;
        uint256 creationTime;
    }

    mapping (uint256 => Swap) public swaps;
    uint256 public swapId;
    mapping (address => bool) public deposited;

    event SwapCreated(uint256 swapId, address nftAddress1, uint256 tokenId1, address nftAddress2, uint256 tokenId2, address party1, address party2, uint256 creationTime);
    event NFTDeposited(uint256 swapId, address nftAddress, uint256 tokenId);

    modifier hasDeposited(uint256 _swapId) {
        Swap memory swap = swaps[_swapId];
        IERC721 nftOne = IERC721(swap.nftAddress1);
        IERC721 nftTwo = IERC721(swap.nftAddress2);
        require(nftOne.ownerOf(swap.tokenId1) == address(this), "NFT One not deposited");
        require(nftTwo.ownerOf(swap.tokenId2) == address(this), "NFT Two not deposited");
        _;
    }

    function createSwap(address _nftAddress1, uint256 _tokenId1, address _nftAddress2, uint256 _tokenId2, address _party1, address _party2) public {
        Swap memory newSwap = Swap(_nftAddress1, _tokenId1, _nftAddress2, _tokenId2, _party1, _party2, block.timestamp);
        swaps[swapId] = newSwap;
        swapId++;
        emit SwapCreated(swapId, _nftAddress1, _tokenId1, _nftAddress2, _tokenId2, _party1, _party2, block.timestamp);
    }

    function depositNft(uint256 _swapId, address nft) public {
        require(nft == swaps[_swapId].nftAddress1 || nft == swaps[_swapId].nftAddress2, "Wrong NFT");
        Swap memory swap = swaps[_swapId];
        if (nft == swap.nftAddress1) {
            IERC721 nftOne = IERC721(nft);
            nftOne.safeTransferFrom(msg.sender, address(this), swap.tokenId1);
            deposited[swap.party1] = true;
            emit NFTDeposited(_swapId, nft, swap.tokenId1);
        } else {
            IERC721 nftTwo = IERC721(nft);
            nftTwo.safeTransferFrom(msg.sender, address(this), swap.tokenId2);
            deposited[swap.party2] = true;
            emit NFTDeposited(_swapId, nft, swap.tokenId2);
        }
    }

    function conductSwap(uint256 _swapId) public hasDeposited(_swapId) {
        require(block.timestamp > swaps[_swapId].creationTime + 1 days, "Swap not yet ready");
        Swap memory swap = swaps[_swapId];
        IERC721 nftOne = IERC721(swap.nftAddress1);
        IERC721 nftTwo = IERC721(swap.nftAddress2);
        nftOne.safeTransferFrom(address(this), swap.party2, swap.tokenId1);
        nftTwo.safeTransferFrom(address(this), swap.party1, swap.tokenId2);
    }
}