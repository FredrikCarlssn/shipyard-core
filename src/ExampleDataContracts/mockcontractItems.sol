//SDPDX-license-identifier: MIT
pragma solidity ^0.8.20;

import {ERC721DynamicTraits} from "src/dynamic-traits/ERC721DynamicTraits.sol";

contract mockcontractItems is ERC721DynamicTraits {
    mapping(uint256 => Item) public numberToItem;

    struct Item {
        string tokenHash;
        bytes32[] traitKeys;
        bytes32[] traitValues;
    }

    // bytes32[] private keys = [
    //     bytes32("1"),
    //     bytes32("2"),
    //     bytes32("3"),
    //     bytes32("4"),
    //     bytes32("5"),
    //     bytes32("6"),
    //     bytes32("7"),
    //     bytes32("8"),
    //     bytes32("9"),
    //     bytes32("10"),
    //     bytes32("11"),
    //     bytes32("12"),
    //     bytes32("13"),
    //     bytes32("14"),
    //     bytes32("15"),
    //     bytes32("16"),
    //     bytes32("17"),
    //     bytes32("18"),
    //     bytes32("19"),
    //     bytes32("20"),
    //     bytes32("21"),
    //     bytes32("22")
    // ];

    /*//////////////////////////////////////////////////////////////
                           Knight's Oathblade
    //////////////////////////////////////////////////////////////*/
    bytes32[] private keys1 = [
        bytes32("1"),
        bytes32("2"),
        bytes32("3"),
        bytes32("4"),
        bytes32("5"),
        bytes32("6"),
        bytes32("8"),
        bytes32("9"),
        bytes32("10"),
        bytes32("11"),
        bytes32("12")
    ];
    bytes32[] private values1 = [
        bytes32("Rare"),
        bytes32("1"),
        bytes32("Physical"),
        bytes32("2-3"),
        bytes32("1.25"),
        bytes32("2.5m"),
        bytes32("9"),
        bytes32("Stun Chance +15-25%"),
        bytes32("Stun Chance +15-25%"),
        bytes32("Movement Speed +15-25%"),
        bytes32("Burn Chance +15-25%")
    ];
    /*//////////////////////////////////////////////////////////////
                          Swiftshadow Stiletto
    //////////////////////////////////////////////////////////////*/
    bytes32[] private keys2 = [
        bytes32("1"),
        bytes32("2"),
        bytes32("3"),
        bytes32("4"),
        bytes32("5"),
        bytes32("6"),
        bytes32("8"),
        bytes32("9"),
        bytes32("10"),
        bytes32("11"),
        bytes32("12"),
        bytes32("13")
    ];
    bytes32[] private values2 = [
        bytes32("Rare"),
        bytes32("2"),
        bytes32("Physical"),
        bytes32("4-5"),
        bytes32("1.25"),
        bytes32("2.5m"),
        bytes32("10"),
        bytes32("Knockback Chance +15-25%"),
        bytes32("Stun Chance +15-25%"),
        bytes32("Stun Chance +15-25%"),
        bytes32("Movement Speed +15-25%"),
        bytes32("Burn Chance +15-25%")
    ];
    /*//////////////////////////////////////////////////////////////
                           ELDRITCH CRESCENT
    //////////////////////////////////////////////////////////////*/
    bytes32[] private keys3 = [
        bytes32("1"),
        bytes32("2"),
        bytes32("3"),
        bytes32("4"),
        bytes32("5"),
        bytes32("6"),
        bytes32("8"),
        bytes32("9"),
        bytes32("10"),
        bytes32("11"),
        bytes32("12"),
        bytes32("13"),
        bytes32("14"),
        bytes32("15")
    ];
    bytes32[] private values3 = [
        bytes32("Rare"),
        bytes32("3"),
        bytes32("Physical"),
        bytes32("3-5"),
        bytes32("1.25"),
        bytes32("2.5m"),
        bytes32("10"),
        bytes32("Knockback Chance +15-25%"),
        bytes32("Stun Chance +15-25%"),
        bytes32("Stun Chance +15-25%"),
        bytes32("Movement Speed +15-25%"),
        bytes32("PhysicalResistanceGlobal +30-50%"),
        bytes32("Movement Speed Global +18-30%"),
        bytes32("Attack Speed Global +18-30%")
    ];
    /*//////////////////////////////////////////////////////////////
                           Titan's Rumbler
    //////////////////////////////////////////////////////////////*/
    // bytes32[] private keys4 = [
    //     bytes32("1"),
    //     bytes32("2"),
    //     bytes32("3"),
    //     bytes32("4"),
    //     bytes32("5"),
    //     bytes32("6"),
    //     bytes32("8"),
    //     bytes32("9"),
    //     bytes32("10"),
    //     bytes32("11"),
    //     bytes32("12"),
    //     bytes32("13"),
    //     bytes32("14")
    // ];
    // bytes32[] private values4 = [
    //     bytes32("Legendary"),
    //     bytes32("4"),
    //     bytes32("Fire"),
    //     bytes32("6-8"),
    //     bytes32("1.25"),
    //     bytes32("2.5m"),
    //     bytes32("9"),
    //     bytes32("Knockback Chance +15-25%"),
    //     bytes32("Stun Chance +15-25%"),
    //     bytes32("Stun Chance +15-25%"),
    //     bytes32("Movement Speed +15-25%"),
    //     bytes32("Stun Chance +30-50%"),
    //     bytes32("Stun Duration +60-100%")
    // ];
    // /*//////////////////////////////////////////////////////////////
    //                        Silversnake Estoc
    // //////////////////////////////////////////////////////////////*/
    // bytes32[] private keys5 = [
    //     bytes32("1"),
    //     bytes32("2"),
    //     bytes32("3"),
    //     bytes32("4"),
    //     bytes32("5"),
    //     bytes32("6"),
    //     bytes32("8"),
    //     bytes32("9"),
    //     bytes32("10"),
    //     bytes32("11"),
    //     bytes32("12"),
    //     bytes32("13"),
    //     bytes32("14"),
    //     bytes32("15"),
    //     bytes32("16"),
    //     bytes32("17"),
    //     bytes32("18"),
    //     bytes32("19"),
    //     bytes32("20"),
    //     bytes32("21"),
    //     bytes32("22")
    // ];
    // bytes32[] private values5 = [
    //     bytes32("Legendary"),
    //     bytes32("4"),
    //     bytes32("Aethereal"),
    //     bytes32("14-21"),
    //     bytes32("1.25"),
    //     bytes32("2.5m"),
    //     bytes32("10"),
    //     bytes32("Knockback Chance +15-25%"),
    //     bytes32("Stun Chance +15-25%"),
    //     bytes32("Movement Speed +15-25%"),
    //     bytes32("Knockback Chance +15-25%"),
    //     bytes32("Stun Chance +15-25%"),
    //     bytes32("Movement Speed +15-25%"),
    //     bytes32("Knockback Chance +15-25%"),
    //     bytes32("Stun Chance +15-25%"),
    //     bytes32("Movement Speed +15-25%"),
    //     bytes32("Knockback Chance +15-25%"),
    //     bytes32("Stun Chance +15-25%"),
    //     bytes32("Stun Chance +15-25%"),
    //     bytes32("Movement Speed +15-25%"),
    //     bytes32("PhysicalResistanceGlobal +30-50%")
    // ];

    /*//////////////////////////////////////////////////////////////
                               FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    constructor()
        ERC721DynamicTraits(0xc9c81Af14eC5d7a4Ca19fdC9897054e2d033bf05, 0xc9c81Af14eC5d7a4Ca19fdC9897054e2d033bf05)
    {
        addItem(1, "QmXycvVpnnGy5cecfqHfgRDnzRoVsEB1eDg3MMbfLHVzCk", keys1, values1);
        addItem(2, "QmPcRgDLea9owAHgQVqx5vSq7nZ7M31uatpUhoovHd2Pn6", keys2, values2);
        addItem(3, "QmTEgcZFNSSo8SA3aQpkgzuwR1UheAk1jX8BHnbxXqxXfY", keys3, values3);
        _setTraitMetadataURI("ipfs://QmULzv8zQ6TEdQgh1LSB2sjYaxcRKnrXgtDQBJBZhP1m3t");
        // addItem(4, "QmeRwRtEkvGc78y1AQ611CPND3cYMcaQBcDwdLTkztnVe2", keys4, values4);
        // addItem(5, "QmS7tvfVVPzaV9JZriCyRHNDAHkZwMktxPr1NE1ERaQzUt", keys5, values5);
    }

    function addItem(
        uint256 _item,
        string memory _tokenHash,
        bytes32[] memory _traitKeys,
        bytes32[] memory _traitValues
    ) public {
        numberToItem[_item] = Item(_tokenHash, _traitKeys, _traitValues);
    }

    function mintItem(uint256 _item) public {
        Item memory item = numberToItem[_item];
        mintWithTraits(0xc9c81Af14eC5d7a4Ca19fdC9897054e2d033bf05, item.tokenHash, item.traitKeys, item.traitValues);
    }

    function mintMultipleItems(uint256[] calldata _items) public {
        for (uint256 i = 0; i < _items.length; i++) {
            mintItem(_items[i]);
        }
    }
}
