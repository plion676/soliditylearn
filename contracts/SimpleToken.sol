// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract SimpleToken {
    uint public totalSupply=1000;
    mapping (address=>uint) balances;
    constructor() {
        balances[msg.sender]=totalSupply;
    }
    function Transfer(address to,uint amount) public{
        require(balances[msg.sender]>=amount,unicode"余额不足");
        balances[msg.sender]-=amount;
        balances[to]+=amount;
    }
    function balanceOf(address user) public view returns(uint){
        return balances[user];
    }
}
//函数内部变量名要会写
//函数最后的可见性等。。。。。...。