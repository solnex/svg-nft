//SPDX-License-Identifier:MIT

pragma solidity ^0.8.16;

import {Test, console} from "forge-std/Test.sol";
import {NftTypes} from "../src/NftTypes.sol";
import {DeployNftTypes} from "../script/DeployNftTypes.s.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract TestNftTypes is Test {
    NftTypes private nftTypes;
    address public MINTER = makeAddr("Bob");
    string private constant _imgUri =
        "ipfs://QmTAYDmsuMtsHt6qpiubndy7CxMPEGANbL72VQAXZzRxhM";
    string private constant baseUri_prefix = "data:image/svg+xml;base64,";
    string private constant PATH = "./imgs/svgNfts/1.svg";
    uint256 private constant INITIAL_BALANCE = 1 ether;

    function setUp() public {
        DeployNftTypes deployer = new DeployNftTypes();
        nftTypes = deployer.run();
        vm.deal(MINTER, INITIAL_BALANCE);
    }

    function testMintUrl() public {
        vm.prank(MINTER);
        uint256 tokenId = nftTypes.mint(_imgUri);

        //when string assert, hash them fisrt
        // assert(nftTypes.tokenURI(tokenId) == _tokenUri);
        assert(
            keccak256(abi.encodePacked(nftTypes.getImageUri(tokenId))) ==
                keccak256(abi.encodePacked(_imgUri))
        );
    }

    function testNftOwner() public {
        vm.prank(MINTER);
        uint256 tokenId = nftTypes.mint(_imgUri);
        assert(nftTypes.ownerOf(tokenId) == MINTER);
    }

    function testTokenUrl() public {
        vm.prank(MINTER);
        uint256 tokenId = nftTypes.mint(_imgUri);
        nftTypes.tokenURI(tokenId);
        console.log(nftTypes.tokenURI(tokenId));
    }

    function testRevertWhenMintToTotalSupply() public {
        //arrange
        vm.startPrank(MINTER);
        uint256 totalSupply = nftTypes.totalSupply();
        for (uint256 i = 0; i < totalSupply; i++) {
            nftTypes.mint(_imgUri);
        }
        vm.stopPrank();
        //act
        vm.prank(MINTER);
        vm.expectRevert(NftTypes.NftTypes_MaxSupplyExceeded.selector);
        nftTypes.mint(_imgUri);
    }

    function testSVGMint() public {
        string memory svg = vm.readFile(PATH);
        string memory base64Svg = Base64.encode(bytes(svg));
        string memory tokenImgUri = string(
            abi.encodePacked(baseUri_prefix, base64Svg)
        );
        vm.prank(MINTER);
        uint256 tokenId = nftTypes.mint(tokenImgUri);
        string memory tokenSVGURI = nftTypes.tokenURI(tokenId);
        console.log(tokenSVGURI);
    }
}
