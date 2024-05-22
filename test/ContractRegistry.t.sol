// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ContractRegistry} from "../src/ContractRegistry.sol";

contract ContractRegistryTest is Test {
    ContractRegistry public registry;

    function setUp() public {
        registry = new ContractRegistry();
    }

    /*function test_SetSetRegistryAddress() public {
        address newAddress = address(0x1);
        registry.setSetRegistryAddress(newAddress);
        assertEq(registry.setRegistryAddress, newAddress);
    }

    function test_SetUserRegistryAddress() public {
        address newAddress = address(0x1);
        registry.setUserRegistryAddress(newAddress);
        assertEq(registry.userRegistryAddress, newAddress);
    }*/
}