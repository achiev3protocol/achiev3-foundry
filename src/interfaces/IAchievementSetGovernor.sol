// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IAchievementSetGovernor {
    function unlockAchievement(uint256 achievementId, address unlockTo) external;
    function setCanAwardAchievements(address account, bool canAward) external;
}