// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import './interfaces/IContractRegistry.sol';

/**
 * @title ContractRegistry
 * @dev Contract for managing the canonical addresses of other contracts in the protocol.
 */
contract ContractRegistry is OwnableUpgradeable, IContractRegistry {
    address setRegistryAddress;
    address userRegistryAddress;

    function initialize() initializer public {
        __Ownable_init(msg.sender);
    }

    function getSetRegistryAddress() external view returns (address) {
        return setRegistryAddress;
    }

    function getUserRegistryAddress() external view returns (address) {
        return userRegistryAddress;
    }

    function setSetRegistryAddress(address _setRegistryAddress) public onlyOwner {
        setRegistryAddress = _setRegistryAddress;
    }

    function setUserRegistryAddress(address _userRegistryAddress) public onlyOwner {
        userRegistryAddress = _userRegistryAddress;
    }
}