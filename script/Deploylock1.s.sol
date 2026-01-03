// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/lock_1.sol";

contract DeployLock1 is Script {
    function run() external {
        address pip = vm.envAddress("PIP_ADDRESS");
        address relayer = vm.envAddress("RELAYER");

        vm.startBroadcast();
        new lock1(pip, relayer);
        vm.stopBroadcast();
    }
}





