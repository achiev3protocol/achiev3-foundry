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
import {UserRegistry} from "../src/UserRegistry.sol";

contract UserRegistryTest is Test {
    UserRegistry public registry;

    function setUp() public {
        registry = new UserRegistry();
    }

    function test_MintUser() public {
        registry.mintUser("Test");
        assertEq(registry.totalSupply(), 1);

        registry.mintUser("Test");
        assertEq(registry.totalSupply(), 2);

        registry.mintUser("Test");
        assertEq(registry.totalSupply(), 3);
    }
}