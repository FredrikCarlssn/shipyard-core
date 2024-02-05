// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {ERC721DynamicTraits} from "src/dynamic-traits/ERC721DynamicTraits.sol";

contract DeployToken is Script {
    function run() public returns (ERC721DynamicTraits) {
        vm.startBroadcast();
        ERC721DynamicTraits weaponTestCollection = new ERC721DynamicTraits(address(0), address(0));
        vm.stopBroadcast();
        return weaponTestCollection;
    }
}
