// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 ("Merkle Token", "MTk") {
    address public owner;
    constructor() payable {
        owner = msg.sender;
        _mint(msg.sender, 10000e18);
    }

    modifier onlyOwner () {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    function mint(uint _amount) external {
        require(msg.sender == owner, "only owner can mint");
        _mint(msg.sender, _amount * 1e18);
    }

    function transferFromContract(address _to, uint256 _amount) external onlyOwner {
    _transfer(address(this), _to, _amount);
}
}