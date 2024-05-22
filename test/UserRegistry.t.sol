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