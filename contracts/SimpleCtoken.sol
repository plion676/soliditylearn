// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SimpleCtoken {

    mapping(address=>uint) public balances;
    function mint() external payable{
        balances[msg.sender]+=msg.value;    
    }
    function redeem(uint amount) external {
        require(balances[msg.sender]>=amount,unicode"余额不足");
        balances[msg.sender]-=amount;
        payable(msg.sender).transfer(amount);
    }
}