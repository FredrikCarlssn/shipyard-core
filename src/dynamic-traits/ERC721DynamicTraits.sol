// SPDX-License-Identifier: CC0-1.0
pragma solidity 0.8.20;

import {ERC721} from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {ERC721Burnable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import {AccessControl} from "openzeppelin-contracts/access/AccessControl.sol";
import {DynamicTraits} from "src/dynamic-traits/DynamicTraits.sol";

error itemInTradeMode();

contract ERC721DynamicTraits is
    DynamicTraits,
    AccessControl,
    ERC721,
    ERC721Enumerable,
    ERC721URIStorage,
    ERC721Burnable
{
    mapping(uint256 => bool) public s_tokenIdToMode; // False = gameMode, True = itemInTradeMode
    uint256 private s_nextTokenId;
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant METADATA_ROLE = keccak256("METADATA_ROLE");

    event ModeChanged(uint256 tokenId, bool mode);

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address defaultAdmin, address minter) ERC721("RustySwords", "RUSTY") {
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _grantRole(MINTER_ROLE, minter);
        _grantRole(METADATA_ROLE, minter);
        _setTraitMetadataURI("ipfs://QmQKFfyxVCDk7cpTLAV6fiDHFGUwBm7Ban5Yz7dFpUWefo");
    }

    /*//////////////////////////////////////////////////////////////
                             URI FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://";
    }

    function setTraitMetadataURI(string calldata _uri) external onlyRole(DEFAULT_ADMIN_ROLE) {
        // Set the new metadata URI.
        _setTraitMetadataURI(_uri);
    }

    /*//////////////////////////////////////////////////////////////
                                MINTING
    //////////////////////////////////////////////////////////////*/
    function mintWithTraits(
        address _recipient,
        string calldata _tokenHash,
        bytes32[] calldata _traitKeys,
        bytes32[] calldata _traitValues
    ) public onlyRole(MINTER_ROLE) {
        uint256 tokenId = s_nextTokenId++;
        _safeMint(_recipient, tokenId);
        _setTokenURI(tokenId, _tokenHash);
        setMultipleTraits(tokenId, _traitKeys, _traitValues);
    }

    /*//////////////////////////////////////////////////////////////
                             UPDATING TRAITS 
    //////////////////////////////////////////////////////////////*/
    //@DEV - NFT must be in gameMode to update traits / s_tokenIdToMode[_tokenId] == true
    function setTraitWithEvent(uint256 _tokenId, bytes32 _traitKey, bytes32 _newValue) public onlyRole(METADATA_ROLE) {
        if (s_tokenIdToMode[_tokenId] == true) revert itemInTradeMode();
        super.setTrait(_tokenId, _traitKey, _newValue);
    }

    function setTrait(uint256 _tokenId, bytes32 _traitKey, bytes32 _newValue) public override onlyRole(METADATA_ROLE) {
        if (s_tokenIdToMode[_tokenId] == true) revert itemInTradeMode();
        _setTrait(_tokenId, _traitKey, _newValue);
    }

    function setMultipleTraitsWithEvent(uint256 _tokenId, bytes32[] memory _traitKeys, bytes32[] memory _traitValues)
        public
        onlyRole(METADATA_ROLE)
    {
        if (s_tokenIdToMode[_tokenId] == true) revert itemInTradeMode();
        uint256 traitsLength = _traitKeys.length;
        for (uint256 i = 0; i < traitsLength; i++) {
            setTrait(_tokenId, _traitKeys[i], _traitValues[i]);
        }
    }

    function setMultipleTraits(uint256 _tokenId, bytes32[] calldata _traitKeys, bytes32[] calldata _traitValues)
        public
        onlyRole(METADATA_ROLE)
    {
        if (s_tokenIdToMode[_tokenId] == true) revert itemInTradeMode();
        uint256 traitsLength = _traitKeys.length;
        for (uint256 i = 0; i < traitsLength; i++) {
            _setTrait(_tokenId, _traitKeys[i], _traitValues[i]);
        }
    }
    /*////////////////////////////////////////////////////////////// 
                            GET TRAITS
    //////////////////////////////////////////////////////////////*/

    function getTraitValue(uint256 _tokenId, bytes32 _traitKey)
        public
        view
        virtual
        override
        returns (bytes32 traitValue)
    {
        // Revert if the token doesn't exist.
        _requireOwned(_tokenId);

        // Call the internal function to get the trait value.
        return DynamicTraits.getTraitValue(_tokenId, _traitKey);
    }

    function getTraitValues(uint256 _tokenId, bytes32[] calldata _traitKeys)
        public
        view
        virtual
        override
        returns (bytes32[] memory traitValues)
    {
        // Revert if the token doesn't exist.
        _requireOwned(_tokenId);

        // Call the internal function to get the trait values.
        return DynamicTraits.getTraitValues(_tokenId, _traitKeys);
    }

    /*//////////////////////////////////////////////////////////////
                                  MODE
    //////////////////////////////////////////////////////////////*/
    function setMode(uint256 tokenId, bool mode) public onlyRole(METADATA_ROLE) {
        s_tokenIdToMode[tokenId] = mode;
        emit ModeChanged(tokenId, mode);
    }

    /*//////////////////////////////////////////////////////////////
                           SUPPORTSINTERFACE
    //////////////////////////////////////////////////////////////*/
    function supportsInterface(bytes4 _interfaceId)
        public
        view
        virtual
        override(ERC721, DynamicTraits, AccessControl, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return (ERC721.supportsInterface(_interfaceId) || DynamicTraits.supportsInterface(_interfaceId));
    }

    /*//////////////////////////////////////////////////////////////
                           SOLIDITY OVERRIDES
    //////////////////////////////////////////////////////////////*/
    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }
}
