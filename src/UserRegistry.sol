pragma solidity ^0.8.13;

import 'erc721a-upgradeable/contracts/ERC721AUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';

/**
 * @title AchievementUserRegistry
 *
 * Enables decoupling of wallets with users in the Achiev3 protocol.
 */
contract UserRegistry is ERC721AUpgradeable, OwnableUpgradeable {
    mapping(address => uint256) userIds;

    string[] displayNames;

    function initialize() initializerERC721A initializer public {
        __ERC721A_init('Achiev3 Users', 'EV3USERS');
        __Ownable_init();
    }

    function mintUser(string calldata displayName) public payable {
        _mint(msg.sender, 1);

        displayNames.push(displayName);
    }

    function setDisplayName(uint256 userId, string calldata displayName) public {
        require(msg.sender == ownerOf, 'AchievementUserRegistry: Not the owner of this user');

        displayNames[userId] = displayName;
    }

    function attestToOwnership(uint256 userId) {
        userIds[msg.sender] = userId;
    }
}