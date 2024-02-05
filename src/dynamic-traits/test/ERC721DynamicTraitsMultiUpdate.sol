// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.19;

import {ERC721DynamicTraits} from "src/dynamic-traits/ERC721DynamicTraits.sol";

contract ERC721DynamicTraitsMultiUpdate is ERC721DynamicTraits {
    constructor() ERC721DynamicTraits(address(0), address(0)) {}

    function setTraitsRange(uint256 fromTokenId, uint256 toTokenId, bytes32 traitKey, bytes32 value) public virtual {
        for (uint256 tokenId = fromTokenId; tokenId <= toTokenId;) {
            // Revert if the token doesn't exist.
            _requireOwned(tokenId);

            // Call the internal function to set the trait.
            _setTrait(tokenId, traitKey, value);

            unchecked {
                ++tokenId;
            }
        }

        // Emit the event noting the update.
        emit TraitUpdatedRangeUniformValue(traitKey, fromTokenId, toTokenId, value);
    }

    function setTraitsRangeDifferentValues(
        uint256 fromTokenId,
        uint256 toTokenId,
        bytes32 traitKey,
        bytes32[] calldata values
    ) public virtual {
        for (uint256 tokenId = fromTokenId; tokenId <= toTokenId;) {
            // Revert if the token doesn't exist.
            _requireOwned(tokenId);

            // Call the internal function to set the trait.
            _setTrait(tokenId, traitKey, values[tokenId - 1]);

            unchecked {
                ++tokenId;
            }
        }

        // Emit the event noting the update.
        emit TraitUpdatedRange(traitKey, fromTokenId, toTokenId);
    }

    function setTraitsList(uint256[] calldata tokenIds, bytes32 traitKey, bytes32 value) public virtual {
        for (uint256 i = 0; i < tokenIds.length;) {
            // Revert if the token doesn't exist.
            _requireOwned(tokenIds[i]);

            // Call the internal function to set the trait.
            _setTrait(tokenIds[i], traitKey, value);

            unchecked {
                ++i;
            }
        }

        // Emit the event noting the update.
        emit TraitUpdatedListUniformValue(traitKey, tokenIds, value);
    }

    function setTraitsListDifferentValues(uint256[] calldata tokenIds, bytes32 traitKey, bytes32[] calldata values)
        public
        virtual
    {
        for (uint256 i = 0; i < tokenIds.length;) {
            // Revert if the token doesn't exist.
            _requireOwned(tokenIds[i]);

            // Call the internal function to set the trait.
            _setTrait(tokenIds[i], traitKey, values[i]);

            unchecked {
                ++i;
            }
        }

        // Emit the event noting the update.
        emit TraitUpdatedList(traitKey, tokenIds);
    }

    function mint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }
}
