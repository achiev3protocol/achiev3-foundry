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
     * @dev Sets the address of the current version of the UserRegistry contract.
     */
    function setUserRegistryAddress(address _userRegistryAddress) external onlyOwner {
        userRegistryAddress = _userRegistryAddress;
    }
}