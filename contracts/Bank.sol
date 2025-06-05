// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Bank {
    mapping (address=>uint256) balances;
    event deposited(address user,uint amount);
    event withdrawed(address user,uint amount);
    function deposit() public payable{
        require(msg.value>0, unicode"存款金额应大于0");
        balances[msg.sender]=balances[msg.sender]+msg.value;
        emit deposited(msg.sender,msg.value);
    }
    function withdraw(uint amount) public{
        require (balances[msg.sender]>=amount,unicode"余额不足");
        balances[msg.sender]=balances[msg.sender]-amount;
        payable(msg.sender).transfer(amount);
        emit withdrawed(msg.sender,amount);
    }
    function getContractBalances() public view returns(uint){
        return balances[msg.sender];
    }//11111111
}
/*暂时没有找到withdraw中输入2就可以取出2eth的方法，问AI说是可以从前端改，如果用—*1ether的方法的话，
好像不符合wei单位的统一标准，若是有很多合约，很麻烦。*/
/*在声明event时，内部只起到一个提醒作用，event(address user)这样子就好，
不用写实际变量，实际变量如msg.sender在触发事件时输入就好*/
//这个合约中deposit主要就是从钱包充钱进合约里，withdraw就是将合约里面的钱取回钱包
/*withdraw这个函数里，需要先更新账户余额再进行取回操作，否则会受到冲入攻击，
通过receive()在更新之前再次进行取回*/
/*withdraw的主要实现就是payable(msg.sender).transfer(amount),
payable(msg.sender)主要原因就是transfer需要payable的函数才行*/
