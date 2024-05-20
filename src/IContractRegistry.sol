pragma solidity ^0.8.13;

interface IContractRegistry {
    function getAchievementSetRegistry() external view returns (address);
    function getAchievementUserRegistry() external view returns (address);
}