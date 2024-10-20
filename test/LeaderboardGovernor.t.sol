/*
             _     _           ____  
            | |   (_)         |___ \ 
   __ _  ___| |__  _  _____   ____) |
  / _` |/ __| '_ \| |/ _ \ \ / /__ < 
 | (_| | (__| | | | |  __/\ V /___) |
  \__,_|\___|_| |_|_|\___| \_/|____/ 

  decentralized, permissionless achievements protocol
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {LeaderboardGovernor} from "../src/leaderboards/LeaderboardGovernor.sol";

contract LeaderboardGovernorTest is Test {
    LeaderboardGovernor leaderboardGovernor;

    function setUp() public {
        leaderboardGovernor = new LeaderboardGovernor("Test", "TEST", address(this), address(this));
    }

    function test_SetLeaderboardIconCid() public {
        leaderboardGovernor.setLeaderboardIconCid("test123");
        assertEq(leaderboardGovernor.leaderboardIconCid(), "test123");

        leaderboardGovernor.setLeaderboardIconCid("test456");
        assertEq(leaderboardGovernor.leaderboardIconCid(), "test456");
    }

    function test_RecordScore() public {
        leaderboardGovernor.recordScore(100, address(this));
        assertEq(leaderboardGovernor.getScoreCount(), 1);
    }
}
