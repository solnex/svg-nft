//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {NftTypes} from "../src/NftTypes.sol";

contract DeployNftTypes is Script {
    NftTypes private nftTypes;

    function run() public returns (NftTypes) {
        vm.startBroadcast();
        nftTypes = new NftTypes();
        vm.stopBroadcast();
        return nftTypes;
    }
}
