// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

contract SignatureVerificationTest is Test {
    SigVerify public verifier;
    Token public token;
    uint256 public constant CLAIM_AMOUNT = 100 * 10**18;
    uint256 private userPrivateKey;
    address public user;


    
    function setUpContracts() public {
        userPrivateKey = 0xA11CE;
        user = vm.addr(userPrivateKey);

        token = new Token();
        verifier = new SigVerify(address(token), CLAIM_AMOUNT);
        token.transfer(address(verifier), 1000 * 10**18);

        address[] memory addresses = new address[](1);
        addresses[0] = user;
        verifier.addToWhitelist(addresses);
    }

}
