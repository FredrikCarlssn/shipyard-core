//SDPDX-license-identifier: MIT
pragma solidity ^0.8.20;

import {ERC721DynamicTraits} from "src/dynamic-traits/ERC721DynamicTraits.sol";

contract mockcontractSkills is ERC721DynamicTraits {
    mapping(uint256 => Skill) public numberToSkill;

    struct Skill {
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
    //     bytes32("22"),
    //     bytes32("23")
    // ];

    /*//////////////////////////////////////////////////////////////
                           Flame Projectile
    //////////////////////////////////////////////////////////////*/
    bytes32[] private keys1 = [
        bytes32("1"),
        bytes32("2"),
        bytes32("4"),
        bytes32("6"),
        bytes32("7"),
        bytes32("9"),
        bytes32("10"),
        bytes32("11"),
        bytes32("12")
    ];
    bytes32[] private values1 = [
        bytes32("5"),
        bytes32("2-4"),
        bytes32("20m"),
        bytes32("1000"),
        bytes32("20-25 Aether"),
        bytes32("25 m/s"),
        bytes32("Stun Chance +15-25%"),
        bytes32("Stun Chance +15-25%"),
        bytes32("Movement Speed +15-25%")
    ];
    /*//////////////////////////////////////////////////////////////
                           Inferno Assault
    //////////////////////////////////////////////////////////////*/
    bytes32[] private keys2 = [
        bytes32("1"),
        bytes32("2"),
        bytes32("4"),
        bytes32("6"),
        bytes32("7"),
        bytes32("8"),
        bytes32("10"),
        bytes32("11"),
        bytes32("12"),
        bytes32("13")
    ];
    bytes32[] private values2 = [
        bytes32("8"),
        bytes32("1-3"),
        bytes32("15m"),
        bytes32("1500"),
        bytes32("40-50 Aether"),
        bytes32("3s"),
        bytes32("Knockback Chance +15-25%"),
        bytes32("Stun Chance +15-25%"),
        bytes32("Stun Chance +15-25%"),
        bytes32("Movement Speed +15-25%")
    ];
    /*//////////////////////////////////////////////////////////////
                           Battle Roar
    //////////////////////////////////////////////////////////////*/
    bytes32[] private keys3 = [
        bytes32("1"),
        bytes32("2"),
        bytes32("3"),
        bytes32("5"),
        bytes32("6"),
        bytes32("7"),
        bytes32("8"),
        bytes32("10"),
        bytes32("11"),
        bytes32("12"),
        bytes32("13")
    ];
    bytes32[] private values3 = [
        bytes32("9"),
        bytes32("1-3"),
        bytes32("8-10s"),
        bytes32("6-10m"),
        bytes32("2000"),
        bytes32("20-25 Aether"),
        bytes32("5s"),
        bytes32("KnockbackChance +15-25%"),
        bytes32("StunChance +15-25%"),
        bytes32("StunChance +15-25%"),
        bytes32("MovementSpeed +15-25%")
    ];
    /*//////////////////////////////////////////////////////////////
                           Blinding Flash
    //////////////////////////////////////////////////////////////*/
    // bytes32[] private keys4 = [
    //     bytes32("1"),
    //     bytes32("2"),
    //     bytes32("3"),
    //     bytes32("5"),
    //     bytes32("6"),
    //     bytes32("7"),
    //     bytes32("10"),
    //     bytes32("11"),
    //     bytes32("12"),
    //     bytes32("13")
    // ];
    // bytes32[] private values4 = [
    //     bytes32("11"),
    //     bytes32("1-3"),
    //     bytes32("8-10s"),
    //     bytes32("6-10m"),
    //     bytes32("5000"),
    //     bytes32("20-25 Aether"),
    //     bytes32("Knockback Chance +15-25%"),
    //     bytes32("Stun Chance +15-25%"),
    //     bytes32("Stun Chance +15-25%"),
    //     bytes32("Movement Speed +15-25%")
    // ];
    // /*//////////////////////////////////////////////////////////////
    //                        Stealth Detector
    // //////////////////////////////////////////////////////////////*/
    // bytes32[] private keys5 = [
    //     bytes32("1"),
    //     bytes32("2"),
    //     bytes32("5"),
    //     bytes32("6"),
    //     bytes32("7"),
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
    //     bytes32("20")
    // ];
    // bytes32[] private values5 = [
    //     bytes32("7"),
    //     bytes32("1-5"),
    //     bytes32("3-5m"),
    //     bytes32("1050"),
    //     bytes32("40-50 Aether"),
    //     bytes32("Knockback Chance +15-25%"),
    //     bytes32("Stun Chance +15-25%"),
    //     bytes32("Movement Speed +15-25%"),
    //     bytes32("knockback Chance +15-25%"),
    //     bytes32("Stun Chance +15-25%"),
    //     bytes32("Movement Speed +15-25%"),
    //     bytes32("Knockback Chance +15-25%"),
    //     bytes32("Stun Chance +15-25%"),
    //     bytes32("Movement Speed +15-25%"),
    //     bytes32("Knockback Chance +15-25%"),
    //     bytes32("Stun Chance +15-25%")
    // ];

    constructor()
        ERC721DynamicTraits(0xc9c81Af14eC5d7a4Ca19fdC9897054e2d033bf05, 0xc9c81Af14eC5d7a4Ca19fdC9897054e2d033bf05)
    {
        _setTraitMetadataURI("ipfs://QmPyryeGBgPwBD3Ec2o8SK2pTYWYxDC2WMxVebwNgq5b5Q");

        addSkill(0, "QmPeJ3uXiFSjRU7xbH8SSsgZm471teRiaPBWMLghTbP4uw", keys1, values1);
        addSkill(1, "QmU92HNKdVSh3MpJrmUSCux27dWd8NjHpJj5tDWVcyLmZr", keys2, values2);
        addSkill(2, "Qmb6HKCFZP5amXnkfseaEZvv9baHpSTuECU15f3EpEDY4h", keys3, values3);
        // addSkill(3, "QmRgwqQnNbqnRxQah4PKBxdqYab1uXsv36jZYarV2PYLEj", keys4, values4);
        // addSkill(4, "QmVkx6Vrhq2jJzPyU8ohrY96v1M3CXZo1CQZrmdZsBMnzW", keys5, values5);
    }

    function addSkill(
        uint256 _skill,
        string memory _tokenHash,
        bytes32[] memory _traitKeys,
        bytes32[] memory _traitValues
    ) public {
        numberToSkill[_skill] = Skill(_tokenHash, _traitKeys, _traitValues);
    }

    function mintItem(uint256 _item) public {
        Skill memory skill = numberToSkill[_item];
        mintWithTraits(0xc9c81Af14eC5d7a4Ca19fdC9897054e2d033bf05, skill.tokenHash, skill.traitKeys, skill.traitValues);
    }

    function mintMultipleItems(uint256[] calldata _items) public {
        for (uint256 i = 0; i < _items.length; i++) {
            mintItem(_items[i]);
        }
    }
}
