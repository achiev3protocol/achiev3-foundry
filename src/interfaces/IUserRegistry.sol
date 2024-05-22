// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IUserRegistry {
    function mintUser(string calldata displayName) external payable;
    function setDisplayName(uint256 userId, string calldata displayName) external;
    function attestToOwnership(uint256 userId) external;
}