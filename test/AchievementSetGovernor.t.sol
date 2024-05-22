// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {AchievementSetGovernor} from "../src/AchievementSetGovernor.sol";
import '../src/structs/Achievement.sol';

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

    function test_UpdateAchievement() public {
        governor.addAchievement("Test", "Test", "Test", "Test");
        governor.updateAchievement(0, "Test1", "Test2", "Test3", "Test4");
        
        Achievement memory ach = governor.getAchievement(0);
        assertEq(ach.name, "Test1");
        assertEq(ach.description, "Test2");
        assertEq(ach.iconCid, "Test3");
        assertEq(ach.imageCid, "Test4");
    }
}