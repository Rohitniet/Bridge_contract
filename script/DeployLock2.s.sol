// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/lock_2.sol";

contract DeployLock2 is Script {
    function run() external {
        address TPIP_ADDRESS = vm.envAddress("TPIP_ADDRESS");
        address RELAYER = vm.envAddress("RELAYER");

        vm.startBroadcast();

        new lock2(TPIP_ADDRESS, RELAYER);

        vm.stopBroadcast();
    }
}
