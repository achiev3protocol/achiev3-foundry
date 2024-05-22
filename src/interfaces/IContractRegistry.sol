// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IContractRegistry {
    function setSetRegistryAddress(address _setRegistryAddress) external;
    function setUserRegistryAddress(address _userRegistryAddress) external;
}