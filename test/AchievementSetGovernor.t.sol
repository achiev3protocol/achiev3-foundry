pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {AchievementSetGovernor} from "../src/AchievementSetGovernor.sol";

contract AchievementSetGovernorTest is Test {
    AchievementSetGovernor public governor;

    function setUp() public {
        governor = new AchievementSetGovernor("Test", "TEST", address(this), address(this));
    }

    function test_AddAchievement() public {
        governor.addAchievement("Test", "Test", "Test", "Test");
        assertEq(governor.getAchievementCount(), 1);

        governor.addAchievement("Test", "Test", "Test", "Test");
        assertEq(governor.getAchievementCount(), 2);

        governor.addAchievement("Test", "Test", "Test", "Test");
        assertEq(governor.getAchievementCount(), 3);
    }
}