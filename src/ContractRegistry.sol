/*
             _     _           ____  
            | |   (_)         |___ \ 
   __ _  ___| |__  _  _____   ____) |
  / _` |/ __| '_ \| |/ _ \ \ / /__ < 
 | (_| | (__| | | | |  __/\ V /___) |
  \__,_|\___|_| |_|_|\___| \_/|____/ 

  decentralized, permissionless achievements protocol
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import './interfaces/IContractRegistry.sol';

/**
 * @title ContractRegistry
 * @dev Contract for managing the canonical addresses of other contracts in the protocol.
 */
contract ContractRegistry is OwnableUpgradeable, IContractRegistry {
    /**
     * @dev Address of the current version of the AchievementSetRegistry contract.
     */
    address public setRegistryAddress;

    address public leaderboardRegistryAddress;

    address public levelsRegistryAddress;

    /**
     * @dev Address of the current version of the UserRegistry contract.
     */
    address public userRegistryAddress;

    function initialize() initializer public {
        __Ownable_init(msg.sender);
    }

    /**
     * @dev Sets the address of the current version of the AchievementSetRegistry contract.
     */
    function setSetRegistryAddress(address _setRegistryAddress) external onlyOwner {
        setRegistryAddress = _setRegistryAddress;
    }

    /**
     * @dev Sets the address of the current version of the LeaderboardRegistry contract.
     */
    function setLeaderboardRegistryAddress(address _leaderboardRegistryAddress) external onlyOwner {
        leaderboardRegistryAddress = _leaderboardRegistryAddress;
    }

    /**
     * @dev Sets the address of the current version of the LevelsRegistry contract.
     */
    function setLevelsRegistryAddress(address _levelsRegistryAddress) external onlyOwner {
        levelsRegistryAddress = _levelsRegistryAddress;
    }

    /**
     * @dev Sets the address of the current version of the UserRegistry contract.
     */
    function setUserRegistryAddress(address _userRegistryAddress) external onlyOwner {
        userRegistryAddress = _userRegistryAddress;
    }
}