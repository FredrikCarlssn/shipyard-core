// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import {mockcontractItems} from "src/ExampleDataContracts/mockcontractItems.sol";

contract mockcontractItemsTest is Test {
    mockcontractItems token;

    function setUp() public {
        token = new mockcontractItems();
    }

    function testWTF() public {
        bytes memory data = abi.encodeWithSelector(
            token.setTraitMetadataURI.selector, "ipfs://QmULzv8zQ6TEdQgh1LSB2sjYaxcRKnrXgtDQBJBZhP1m3t"
        ); //1

        // bytes memory data = abi.encodeWithSelector(token.mintItem.selector, 1); //1
        // Items:  0x47C74BbD0c74D57e4e443c86442EF49E2a0969A1
        // Skills: 0x42DF3C5E15Aa2cb0d0A61ED327DDF6278363322c
        console.logBytes(data);
        //0x17fb85940000000000000000000000000000000000000000000000000000000000000001
    }
}
