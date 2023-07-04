//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {NftTypes} from "../src/NftTypes.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MintNft is Script {
    string private constant baseUri_prefix = "data:image/svg+xml;base64,";

    function run() public {
        console.log("chainid:", block.chainid);
        address recentDeployed = DevOpsTools.get_most_recent_deployment(
            "NftTypes",
            block.chainid
        );
        mintSVGNft(recentDeployed);
    }

    function mintSVGNft(address recentDeployed) public {
        //获取伪随机数
        uint256 randomNumber = uint256(
            keccak256(
                abi.encodePacked(
                    msg.sender,
                    recentDeployed,
                    block.timestamp,
                    block.number
                )
            )
        );
        //获取总供应量
        console.log("randomNumber: ", randomNumber);
        uint256 totalSupply = NftTypes(recentDeployed).totalSupply();
        //获取index

        uint8 index = uint8(randomNumber % totalSupply) + 1;
        console.log("index: ", index);

        //获取文件path
        string memory path = string(
            abi.encodePacked("./imgs/svgNfts/", vm.toString(index), ".svg")
        );
        console.log("path: ", path);
        string memory svg = vm.readFile(path);
        console.log("svg: ", svg);
        string memory base64Svg = Base64.encode(bytes(svg));
        string memory tokenImgUri = string(
            abi.encodePacked(baseUri_prefix, base64Svg)
        );

        vm.startBroadcast();
        uint256 tokenId = NftTypes(recentDeployed).mint(tokenImgUri);
        vm.stopBroadcast();

        console.log("tokenId: ", tokenId);
    }
}
