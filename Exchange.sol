// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Exchange {
    mapping(address=>uint) tokenBlances;

    function deposit(uint amount) public {
        tokenBlances[msg.sender]+=amount;
    }

    function gettokenBlances() public view returns(uint){
        return tokenBlances[msg.sender];
    }
    
}