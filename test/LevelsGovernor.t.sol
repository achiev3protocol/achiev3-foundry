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
import {LevelsGovernor} from "../src/levels/LevelsGovernor.sol";

contract LevelsGovernorTest is Test {
    LevelsGovernor levelsGovernor;

    function setUp() public {
        levelsGovernor = new LevelsGovernor("Test", "TEST", address(this), address(this), 100, 1000, 1);
    }

    function test_AwardXp() public {
        levelsGovernor.awardXp(address(this), 100);
        assertEq(levelsGovernor.balanceOf(address(this)), 100);
    }
}

