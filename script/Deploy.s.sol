// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {LevelsRegistry} from "../src/levels/LevelsRegistry.sol";
import {AchievementSetRegistry} from "../src/AchievementSetRegistry.sol";
import {LeaderboardRegistry} from "../src/leaderboards/LeaderboardRegistry.sol";
import {UserRegistry} from "../src/UserRegistry.sol";
import {ContractRegistry} from "../src/ContractRegistry.sol";

contract Deploy is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        ContractRegistry contractRegistry = new ContractRegistry();
        UserRegistry userRegistry = new UserRegistry(address(contractRegistry));
        LevelsRegistry levelsRegistry = new LevelsRegistry(address(contractRegistry));
        AchievementSetRegistry achievementSetRegistry = new AchievementSetRegistry(address(contractRegistry));
        LeaderboardRegistry leaderboardRegistry = new LeaderboardRegistry(address(contractRegistry));

        vm.stopBroadcast();
    }
}