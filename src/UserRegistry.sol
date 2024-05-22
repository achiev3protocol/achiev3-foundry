// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import 'erc721a-upgradeable/contracts/ERC721AUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import './interfaces/IUserRegistry.sol';

error NotAuthorizedToUpdateUser();

/**
 * @title AchievementUserRegistry
 * @dev Tracks users. Enables decoupling of wallets with users in the Achiev3 protocol.
 */
contract UserRegistry is ERC721AUpgradeable, OwnableUpgradeable, IUserRegistry {
    /**
     * @dev Maps wallet addresses to a token/user ID.
     */
    mapping(address => uint256) userIds;

    /**
     * @dev Display names for each user.
     */
    string[] displayNames;

    function initialize() initializerERC721A initializer public {
        __ERC721A_init('Achiev3 Users', 'EV3USERS');
        __Ownable_init(msg.sender);
    }

    /**
     * @dev Mints a new user NFT and associates it with the caller.
     */
    function mintUser(string calldata displayName) external payable {
        _mint(msg.sender, 1);

        displayNames.push(displayName);
    }

    /**
     * @dev Set a new display name for the given user account.
     */
    function setDisplayName(uint256 userId, string calldata displayName) external {
        if(msg.sender != ownerOf(userId)) {
            revert NotAuthorizedToUpdateUser();
        }

        displayNames[userId] = displayName;
    }

    /**
     * @dev Attests that a given wallet is connected to a given user.
     */
    function attestToOwnership(uint256 userId) public {
        userIds[msg.sender] = userId;
    }
}