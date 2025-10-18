// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {BasedToken} from "../src/BasedToken.sol";

contract BasedTokenScript is Script {
    BasedToken public basedToken;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        basedToken = new BasedToken();

        vm.stopBroadcast();
    }
}
