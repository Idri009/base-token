// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {BaseToken} from "../src/BaseToken.sol";

contract BaseScript is Script {
    BaseToken public baseToken;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        baseToken = new BaseToken();

        vm.stopBroadcast();
    }
}
