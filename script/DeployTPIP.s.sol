// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/tpip.sol";

contract DeployTpip is Script {
    function run() external {
        vm.startBroadcast();
        new Tpip("Test Pip", "tPIP");
        vm.stopBroadcast();
    }
}

