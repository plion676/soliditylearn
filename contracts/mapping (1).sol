// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Mapping  {

    mapping(address=>uint256) public balances;
    event BalanceSet(address user,uint amount);
    function setBlances(uint amount) public{
        balances[msg.sender]=amount;
        emit BalanceSet(msg.sender,amount);
    }
    function getBlances() view public returns(uint){
        return balances[msg.sender];
    }
}
