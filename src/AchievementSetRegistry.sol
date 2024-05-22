// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import 'erc721a-upgradeable/contracts/ERC721AUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import './AchievementSetGovernor.sol';
import './interfaces/IAchievementSetRegistry.sol';

/**
 * @title AchievementSetRegistry
 * @dev Keeps track of all achievement sets in the protocol.
 */
contract AchievementSetRegistry is ERC721AUpgradeable, OwnableUpgradeable, IAchievementSetRegistry {
    address[] setContracts;

    address contractRegistry;

    function initialize() initializerERC721A initializer public {
        __ERC721A_init('Achiev3 Sets', 'EV3SETS');
        __Ownable_init(msg.sender);
    }

    /**
    * @dev Returns the address of the governor contract for a given set.
    */
    function ownerOf(uint256 tokenId) public view override returns (address) {
        return AchievementSetGovernor(setContracts[tokenId]).owner();
    }

    /**
     * @dev Mints a new achievement set NFT and creates a new governor contract for it.
     */
    function mintSet(string calldata name, string calldata symbol) external payable {
        // Mint a new NFT that represents ownership of this achievement set
        _mint(msg.sender, 1);

        // Create a new governor contract for this achievement set
        AchievementSetGovernor governor = new AchievementSetGovernor{salt: keccak256(abi.encodePacked(msg.sender))}(
            name, 
            symbol,
            contractRegistry, 
            msg.sender
        );

        // Store the address of our newly created governor
        setContracts.push(address(governor));
    }
}
