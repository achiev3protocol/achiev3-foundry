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
import {AchievementSetRegistry} from "../src/AchievementSetRegistry.sol";

contract AchievementSetRegistryTest is Test {
    AchievementSetRegistry public registry;

    function setUp() public {
        registry = new AchievementSetRegistry();
    }

    function test_MintSet() public {
        uint256 mintFee = registry.registrationFee();

        registry.mintSet{value: mintFee}("Test", "TEST");
        assertEq(registry.totalSupply(), 1);
    }
}