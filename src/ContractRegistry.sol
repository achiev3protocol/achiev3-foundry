// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import './interfaces/IContractRegistry.sol';

/**
 * @title ContractRegistry
 * @dev Contract for managing the canonical addresses of other contracts in the protocol.
 */
contract ContractRegistry is OwnableUpgradeable, IContractRegistry {
    address public setRegistryAddress;
    address public userRegistryAddress;

    function initialize() initializer public {
        __Ownable_init(msg.sender);
    }

    function setSetRegistryAddress(address _setRegistryAddress) external onlyOwner {
        setRegistryAddress = _setRegistryAddress;
    }

    function setUserRegistryAddress(address _userRegistryAddress) external onlyOwner {
        userRegistryAddress = _userRegistryAddress;
    }
}