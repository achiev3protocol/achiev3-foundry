pragma solidity ^0.8.13;

interface IContractRegistry {
    function getSetRegistryAddress() external view returns (address);
    function getUserRegistryAddress() external view returns (address);
}