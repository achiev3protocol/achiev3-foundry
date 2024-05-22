// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {AchievementSetRegistry} from "../src/AchievementSetRegistry.sol";

contract AchievementSetRegistryTest is Test {
    AchievementSetRegistry public registry;

    function setUp() public {
        registry = new AchievementSetRegistry();
    }

    function test_MintSet() public {
        registry.mintSet("Test", "TEST");
        assertEq(registry.totalSupply(), 1);
    }
}