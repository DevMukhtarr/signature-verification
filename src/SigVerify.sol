// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract SigVerify {
    using ECDSA for bytes32;

    IERC20 public token;
    mapping(address => bool) public whitelist;
    mapping(bytes32 => bool) public usedHashes;
    uint256 public claimAmount;

    constructor(address _token, uint256 _claimAmount) {
        token = IERC20(_token);
        claimAmount = _claimAmount;
    }

    function addToWhitelist(address[] calldata addresses) external {
        for (uint i = 0; i < addresses.length; i++) {
            whitelist[addresses[i]] = true;
        }
    }

    function claimTokens(bytes32 messageHash, bytes memory signature) external {
        require(!usedHashes[messageHash], "Signature already used");
        require(whitelist[msg.sender], "Address not whitelisted");
        address signer = messageHash.recover(signature);
        require(signer == msg.sender, "Invalid signature");
        usedHashes[messageHash] = true;
        require(token.transfer(msg.sender, claimAmount), "Token transfer failed");
    }

    function isWhitelisted(address account) external view returns (bool) {
        return whitelist[account];
    }
}