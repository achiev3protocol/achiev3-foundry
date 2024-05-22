// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IAchievementSetRegistry {
    function mintSet(string calldata name, string calldata symbol) external payable;
}