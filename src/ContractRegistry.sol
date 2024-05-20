pragma solidity ^0.8.13;

import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import './IContractRegistry.sol';

contract ContractRegistry is OwnableUpgradeable, IContractRegistry {
    address setRegistryAddress;
    address userRegistryAddress;

    function initialize() initializer public {
        __Ownable_init();
    }

    function getSetRegistryAddress() public view override returns (address) {
        return setRegistryAddress;
    }

    function getUserRegistryAddress() public view override returns (address) {
        return userRegistryAddress;
    }

    function setSetRegistryAddress(address _setRegistryAddress) public onlyOwner {
        setRegistryAddress = _setRegistryAddress;
    }

    function setUserRegistryAddress(address _userRegistryAddress) public onlyOwner {
        userRegistryAddress = _userRegistryAddress;
    }
}