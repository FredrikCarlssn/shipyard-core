// SPDX-License-Identifier: CC0-1.0
pragma solidity 0.8.20;

import {ERC721} from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";
import {DynamicTraits} from "src/dynamic-traits/DynamicTraits.sol";

contract ERC721DynamicTraits is DynamicTraits, Ownable, ERC721 {
    uint256 public tokenIdCounter;

    mapping(uint256 => string) public tokenIdToHash;

    /*//////////////////////////////////////////////////////////////
                           GET ALL ITEM DATA
    //////////////////////////////////////////////////////////////*/
    bytes32[] public itemTraitKeys = [
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
    ]; // 1-21

    function getItemTraitKeys() public view returns (bytes32[] memory) {
        return itemTraitKeys;
    }

    function getItemTraits(uint256 tokenId) public view returns (bytes32[] memory) {
        return this.getTraitValues(tokenId, itemTraitKeys);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory tokenHash = tokenIdToHash[tokenId];
        return string.concat("ipfs://", tokenHash);
    }
    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor() Ownable(msg.sender) ERC721("ERC721DynamicTraits", "ERC721DT") {
        _setTraitMetadataURI("ipfs://QmQKFfyxVCDk7cpTLAV6fiDHFGUwBm7Ban5Yz7dFpUWefo");
    }
    /*//////////////////////////////////////////////////////////////
                                MINTING
    //////////////////////////////////////////////////////////////*/

    function mintWithTraits(
        address _recipient,
        uint256 _tokenId,
        string calldata _tokenHash,
        bytes32[] calldata _traitKeys,
        bytes32[] calldata _traitValues
    ) public {
        _mint(_recipient, _tokenId);
        tokenIdToHash[_tokenId] = _tokenHash;
        setMultipleTraitsWithEvent(_tokenId, _traitKeys, _traitValues);
    }

    /*//////////////////////////////////////////////////////////////
                             UPDATING ITEM
    //////////////////////////////////////////////////////////////*/
    function setTraitWithEvent(uint256 tokenId, bytes32 traitKey, bytes32 newValue) public onlyOwner {
        super.setTrait(tokenId, traitKey, newValue);
    }

    function setTrait(uint256 tokenId, bytes32 traitKey, bytes32 newValue) public override onlyOwner {
        _setTrait(tokenId, traitKey, newValue);
    }

    function setMultipleTraitsWithEvent(uint256 tokenId, bytes32[] calldata traitKeys, bytes32[] calldata traitValues)
        public
        onlyOwner
    {
        uint256 traitsLength = traitKeys.length;
        for (uint256 i = 0; i < traitsLength; i++) {
            setTrait(tokenId, traitKeys[i], traitValues[i]);
        }
    }

    function setMultipleTraits(uint256 tokenId, bytes32[] calldata traitKeys, bytes32[] calldata traitValues)
        public
        onlyOwner
    {
        uint256 traitsLength = traitKeys.length;
        for (uint256 i = 0; i < traitsLength; i++) {
            _setTrait(tokenId, traitKeys[i], traitValues[i]);
        }
    }
    /*//////////////////////////////////////////////////////////////
                                .......
    //////////////////////////////////////////////////////////////*/

    function getTraitValue(uint256 tokenId, bytes32 traitKey)
        public
        view
        virtual
        override
        returns (bytes32 traitValue)
    {
        // Revert if the token doesn't exist.
        _requireOwned(tokenId);

        // Call the internal function to get the trait value.
        return DynamicTraits.getTraitValue(tokenId, traitKey);
    }

    function getTraitValues(uint256 tokenId, bytes32[] calldata traitKeys)
        public
        view
        virtual
        override
        returns (bytes32[] memory traitValues)
    {
        // Revert if the token doesn't exist.
        _requireOwned(tokenId);

        // Call the internal function to get the trait values.
        return DynamicTraits.getTraitValues(tokenId, traitKeys);
    }

    function setTraitMetadataURI(string calldata uri) external onlyOwner {
        // Set the new metadata URI.
        _setTraitMetadataURI(uri);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, DynamicTraits) returns (bool) {
        return ERC721.supportsInterface(interfaceId) || DynamicTraits.supportsInterface(interfaceId);
    }
}
