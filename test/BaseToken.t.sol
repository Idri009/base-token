// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {BaseToken} from "../src/BaseToken.sol";

contract BaseTest is Test {
    BaseToken internal token;

    address internal owner;
    address internal user1;
    address internal user2;

    // setUp() runs before each test function - it's like a constructor for tests
    function setUp() public {
        owner = makeAddr("owner");
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");

        vm.deal(owner, 100 ether);
        vm.deal(user1, 100 ether);
        vm.deal(user2, 100 ether);

        // vm.prank() makes the next function call come from the specified address
        vm.prank(owner);
        // Deploy a new Base contract with 'owner' as the deployer
        token = new BaseToken();
    }

    function test_constructor_setsCorrectNameAndSymbol() public {
        // assertEq() checks if two values are equal, fails the test if not
        assertEq(token.name(), "Base");
        assertEq(token.symbol(), "BASE");
    }

    function test_constructor_mintsInitialSupply() public {
        uint256 expectedSupply = 1000 * 10 ** token.decimals();
        assertEq(token.totalSupply(), expectedSupply);
    }

    function test_constructor_grantsOwnerRole() public {
        // assertTrue() checks if a condition is true, fails if false
        // hasRole() checks if an address has a specific role
        assertTrue(token.hasRole(token.OWNER_ROLE(), owner));
    }

    function test_mint_success() public {
        uint256 amount = 500 * 10 ** token.decimals();

        uint256 initialBalance = token.balanceOf(user1);

        vm.prank(owner);
        token.mint(user1, amount);

        assertEq(token.balanceOf(user1), initialBalance + amount);
    }
}
