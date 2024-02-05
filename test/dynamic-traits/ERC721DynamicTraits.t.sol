// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {IERC721Errors} from "openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol";
import {ERC721} from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {IERC7496} from "src/dynamic-traits/interfaces/IERC7496.sol";
import {ERC721DynamicTraits} from "src/dynamic-traits/ERC721DynamicTraits.sol";
import {Solarray} from "solarray/Solarray.sol";

contract ERC721DynamicTraitsMintable is ERC721DynamicTraits, Test {
    address alice = makeAddr("alice");

    constructor() ERC721DynamicTraits(alice, alice) {}

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }
}

contract ERC721DynamicTraitsTest is Test {
    ERC721DynamicTraitsMintable token;

    address alice = makeAddr("alice");

    bytes32[] public traitKeys = [
        bytes32("1"),
        bytes32("2"),
        bytes32("3"),
        bytes32("4"),
        bytes32("5"),
        bytes32("6"),
        bytes32("7"),
        bytes32("8"),
        bytes32("9"),
        bytes32("10"),
        bytes32("11"),
        bytes32("12"),
        bytes32("13"),
        bytes32("14"),
        bytes32("15"),
        bytes32("16"),
        bytes32("17"),
        bytes32("18"),
        bytes32("19"),
        bytes32("20"),
        bytes32("21")
    ];

    bytes32[] public traitKeys2 = [bytes32("1"), bytes32("2"), bytes32("3"), bytes32("4"), bytes32("5")];
    bytes32[] public shortTraits = [
        bytes32("yesyepyesno"),
        bytes32("noyesyesno"),
        bytes32("yesyesyesno"),
        bytes32("yesyesyesno"),
        bytes32("yesyesyesno")
    ];

    string public exampleHash = "QmPQS23UhMwzMQSdxGbaCdrzmgj5Q7ows4BhEzDxSmjBaQ";

    bytes32[] public traitValues1 = [
        bytes32("OneTestblablabla"),
        bytes32("TwoTestblablabla"),
        bytes32("ThreeTestblablabla"),
        bytes32("FourTestblablabla"),
        bytes32("FiveTestblablabla"),
        bytes32("SixTestblablabla"),
        bytes32("SevenTestblablabla"),
        bytes32("EightTestblablabla"),
        bytes32("NineTestblablabla"),
        bytes32("TenTestblablabla"),
        bytes32("ElevenTestblablabla"),
        bytes32("TwelveTestblablabla"),
        bytes32("ThirteenTestblablabla"),
        bytes32("FourteenTestblablabla"),
        bytes32("FifteenTestblablabla"),
        bytes32("SixteenTestblablabla"),
        bytes32("SeventeenTestblablabla"),
        bytes32("EighteenTestblablabla"),
        bytes32("NineteenTestblablabla"),
        bytes32("TwentyTestblablabla"),
        bytes32("TwentyOneTestblablabla")
    ];

    string[] public traitValues = [
        string("red"),
        string("orange"),
        string("yellow"),
        string("green"),
        string("blue"),
        string("purple"),
        string("pink"),
        string("brown"),
        string("black"),
        string("white"),
        string("gray"),
        string("silver"),
        string("gold"),
        string("bronze"),
        string("copper"),
        string("platinum"),
        string("ruby"),
        string("sapphire"),
        string("emerald"),
        string("diamond"),
        string("pearl")
    ];

    string[] public traitValues3 = [
        string("one"),
        string("two"),
        string("three"),
        string("four"),
        string("five"),
        string("six"),
        string("seven"),
        string("eight"),
        string("nine"),
        string("ten"),
        string("eleven"),
        string("twelve"),
        string("thirteen"),
        string("fourteen"),
        string("fifteen"),
        string("sixteen"),
        string("seventeen"),
        string("eighteen"),
        string("nineteen"),
        string("twenty"),
        string("twenty-one")
    ];
    /* Events */

    function getArrayRange(bytes32[] memory dataArray, uint256 start, uint256 end)
        internal
        pure
        returns (bytes32[] memory)
    {
        require(start <= end && end < dataArray.length, "Invalid range");

        // Calculate the length of the new array
        uint256 length = end - start + 1;

        // Create a new array with the calculated length
        bytes32[] memory result = new bytes32[](length);

        // Populate the new array with values from the specified range
        for (uint256 i = 0; i < length; i++) {
            result[i] = dataArray[start + i];
        }

        return result;
    }

    event TraitUpdated(bytes32 indexed traitKey, uint256 tokenId, bytes32 trait);
    event TraitMetadataURIUpdated();

    function setUp() public {
        token = new ERC721DynamicTraitsMintable();
    }

    function testSupportsInterfaceId() public {
        assertTrue(token.supportsInterface(type(IERC7496).interfaceId));
    }

    function testReturnsValueSet() public {
        bytes32 key = bytes32("testKey");
        bytes32 value = bytes32("foo");
        uint256 tokenId = 12345;
        token.mint(address(this), tokenId);

        vm.expectEmit(true, true, true, true);
        emit TraitUpdated(key, tokenId, value);

        token.setTrait(tokenId, key, value);

        assertEq(token.getTraitValue(tokenId, key), value);
    }

    function testOnlyOwnerCanSetValues() public {
        vm.prank(alice);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, alice));
        token.setTrait(0, bytes32("test"), bytes32("test"));
    }

    function testSetTrait_Unchanged() public {
        bytes32 key = bytes32("testKey");
        bytes32 value = bytes32("foo");
        uint256 tokenId = 1;
        token.mint(address(this), tokenId);

        token.setTrait(tokenId, key, value);
        vm.expectRevert(IERC7496.TraitValueUnchanged.selector);
        token.setTrait(tokenId, key, value);
    }

    function testGetTraitValues() public {
        bytes32 key1 = bytes32("testKeyOne");
        bytes32 key2 = bytes32("testKeyTwo");
        bytes32 value1 = bytes32("foo");
        bytes32 value2 = bytes32("bar");
        uint256 tokenId = 1;
        token.mint(address(this), tokenId);

        token.setTrait(tokenId, key1, value1);
        token.setTrait(tokenId, key2, value2);

        bytes32[] memory values = token.getTraitValues(tokenId, Solarray.bytes32s(key1, key2));
        assertEq(values[0], value1);
        assertEq(values[1], value2);
    }

    function testGetAndSetTraitMetadataURI() public {
        string memory uri = "https://example.com/labels.json";

        vm.expectEmit(true, true, true, true);
        emit TraitMetadataURIUpdated();
        token.setTraitMetadataURI(uri);

        assertEq(token.getTraitMetadataURI(), uri);

        vm.prank(address(0x1234));
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, address(0x1234)));
        token.setTraitMetadataURI(uri);
    }

    function testGetAndSetTraitValue_NonexistantToken() public {
        bytes32 key = bytes32("testKey");
        bytes32 value = bytes32(uint256(1));
        uint256 tokenId = 1;

        vm.expectRevert(abi.encodeWithSelector(IERC721Errors.ERC721NonexistentToken.selector, tokenId));
        token.setTrait(tokenId, key, value);

        vm.expectRevert(abi.encodeWithSelector(IERC721Errors.ERC721NonexistentToken.selector, tokenId));
        token.getTraitValue(tokenId, key);

        vm.expectRevert(abi.encodeWithSelector(IERC721Errors.ERC721NonexistentToken.selector, tokenId));
        token.getTraitValues(tokenId, Solarray.bytes32s(key));
    }

    function testGetTraitValue_DefaultZeroValue() public {
        bytes32 key = bytes32("testKey");
        uint256 tokenId = 1;
        token.mint(address(this), tokenId);

        bytes32 value = token.getTraitValue(tokenId, key);
        assertEq(value, bytes32(0), "should return bytes32(0)");

        bytes32[] memory values = token.getTraitValues(tokenId, Solarray.bytes32s(key));
        assertEq(values[0], bytes32(0), "should return bytes32(0)");
    }

    // function testMintAndSetTraitsWithEvent() public {
    //     uint256 tokenId = 1;
    //     token.mint(alice, tokenId);
    //     token.setMultipleTraitsWithEvent(tokenId, traitKeys, traitValues1);
    //     token.setMultipleTraitsWithEvent(tokenId, traitKeys, traitValues2);
    //     token.setMultipleTraitsWithEvent(tokenId, traitKeys, traitValues3);
    // }

    // function testMintAndSetTraits() public {
    //     uint256 tokenId = 1;
    //     token.mint(alice, tokenId);
    //     token.setMultipleTraits(tokenId, traitKeys, traitValues1);
    //     token.setMultipleTraits(tokenId, traitKeys, traitValues2);
    //     token.setMultipleTraits(tokenId, traitKeys, traitValues3);
    // }

    // function testMintAndSet5TraitsAtOnce() public {
    //     uint256 tokenId = 1;
    //     token.mint(alice, tokenId);

    //     bytes32[] memory keys = getArrayRange(traitKeys, 0, 5);
    //     bytes32[] memory values = getArrayRange(traitValues1, 0, 5);
    //     bytes32[] memory values2 = getArrayRange(traitValues2, 0, 5);
    //     bytes32[] memory values3 = getArrayRange(traitValues3, 0, 5);

    //     token.setMultipleTraits(tokenId, keys, values);
    //     token.setMultipleTraits(tokenId, keys, values2);
    //     token.setMultipleTraits(tokenId, keys, values3);
    // }

    // function testMintAndSet5TraitsAtOnceWithEvent() public {
    //     uint256 tokenId = 1;
    //     token.mint(alice, tokenId);

    //     bytes32[] memory keys = getArrayRange(traitKeys, 0, 5);
    //     bytes32[] memory values = getArrayRange(traitValues1, 0, 5);
    //     bytes32[] memory values2 = getArrayRange(traitValues2, 0, 5);
    //     bytes32[] memory values3 = getArrayRange(traitValues3, 0, 5);

    //     token.setMultipleTraitsWithEvent(tokenId, keys, values);
    //     token.setMultipleTraitsWithEvent(tokenId, keys, values2);
    //     token.setMultipleTraitsWithEvent(tokenId, keys, values3);
    // }

    // function testMintAndSet5TraitsOnePerTransaction() public {
    //     uint256 tokenId = 1;
    //     vm.prank(alice);
    //     token.mintWithTraits(alice, tokenId, exampleHash, traitKeys, traitValues1);

    // bytes32[] memory keys = getArrayRange(traitKeys, 0, 5);
    // bytes32[] memory values2 = getArrayRange(traitValues2, 0, 5);
    // bytes32[] memory values3 = getArrayRange(traitValues3, 0, 5);

    // for (uint256 i = 0; i < keys.length; i++) {
    //     vm.prank(alice);
    //     token.setTrait(tokenId, keys[i], values2[i]);
    // }

    // for (uint256 i = 0; i < keys.length; i++) {
    //     vm.prank(alice);
    //     token.setTrait(tokenId, keys[i], values3[i]);
    // }
    // }

    // function testStringArrayToBytes32Array() public {
    //     vm.prank(alice);
    //     token.mint(alice, 1);
    //     vm.prank(alice);
    //     token.stringArrayToBytes32Array(traitKeys);
    //     vm.prank(alice);
    //     token.stringArrayToBytes32Array(traitValues2);
    //     vm.prank(alice);
    //     token.stringArrayToBytes32Array(traitValues1);

    //     // assertEq(bytes32Array[2], bytes32("3"));
    // }

    //     function testMintAndSet5TraitsOnePerTransactionWithEvent() public {
    //         uint256 tokenId = 1;
    //         vm.prank(alice);
    //         token.mintWithTraits(alice, tokenId, exampleHash, traitKeys, traitValues1);

    //         bytes32[] memory keys = getArrayRange(traitKeys, 0, 5);
    //         bytes32[] memory values2 = getArrayRange(traitValues2, 0, 5);
    //         bytes32[] memory values3 = getArrayRange(traitValues3, 0, 5);

    //         for (uint256 i = 0; i < keys.length; i++) {
    //             vm.prank(alice);
    //             token.setTraitWithEvent(tokenId, keys[i], values2[i]);
    //         }

    //         for (uint256 i = 0; i < keys.length; i++) {
    //             vm.prank(alice);
    //             token.setTraitWithEvent(tokenId, keys[i], values3[i]);
    //         }
    //         string memory uri = token.tokenURI(tokenId);
    //         console.log(uri);
    //     }
    function testMintWithTraitsAbiEncoded() public {
        address myAddress = address(0xc9c81Af14eC5d7a4Ca19fdC9897054e2d033bf05);
        bytes memory data =
            abi.encodeWithSelector(token.mintWithTraits.selector, myAddress, exampleHash, traitKeys2, shortTraits);
        console.logBytes(data);
        vm.prank(alice);
        token.mintWithTraits(myAddress, exampleHash, traitKeys, traitValues1);
        vm.expectRevert(data);
    }
}
