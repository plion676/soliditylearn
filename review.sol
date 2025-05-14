// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*contract Bank {
    mapping(address=>uint) public balances;
    event deposited(address user,uint value);
    event withdrawed(address user,uint value);
    function deposit() public payable{
        require(msg.value>0,unicode"充值金额需大于0");
        balances[msg.sender]+=msg.value;
        emit deposited(msg.sender,msg.value);
    }
    function withdraw(uint amount) public{
        require(balances[msg.sender]>=amount,unicode"余额不足");
        balances[msg.sender]-=amount;
        payable(msg.sender).transfer(amount);
        emit withdrawed(msg.sender,amount);
    }
    function getContractBalance() public view returns(uint){
        return balances[msg.sender];
    }
}    主要有一些写法上的错误，逻辑上没啥问题，多写写                   */