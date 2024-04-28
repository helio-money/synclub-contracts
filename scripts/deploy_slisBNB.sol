// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/Test.sol";

import "../contracts/SLisBNB.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract DeploySlisBNB is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        address admin = vm.envAddress("ADMIN_ADDRESS");
        vm.startBroadcast(deployerPrivateKey);
        SLisBNB slisBNB = new SLisBNB();

        bytes memory data = abi.encodeWithSelector(SLisBNB.initialize.selector, admin);
        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(address(slisBNB), deployer, data);
        vm.stopBroadcast();

        console.log("SLisBNB implementation deployed at: ", address(slisBNB));
        console.log("SLisBNB proxy deployed at: ", address(proxy));
    }
}