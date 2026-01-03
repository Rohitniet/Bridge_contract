// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/pip.sol";

contract DeployPIP is Script {
    function run() external {
        vm.startBroadcast();
        new Pip("Pip Token", "PIP");
        vm.stopBroadcast();
    }
}
