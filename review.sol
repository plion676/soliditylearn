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

/*contract Crowedfunding {
    uint deadline;
    address owner;
    uint totalRaised;
    uint goal;
    event contributed(address contributer,uint amount);
    event withdrawed(address owner,uint amount);
    event refunded(address refunder,uint amount);
    mapping(address=>uint) balances;
    constructor(uint fundinSeconds,uint _goal) {
        owner=msg.sender;
        deadline=block.timestamp+fundinSeconds;
        goal=_goal;
    }

    function contribute() public payable{
        require(block.timestamp<=deadline,unicode"已截止");
        require(msg.value>0,unicode"捐赠金额不能为零");
        balances[msg.sender]+=msg.value;
        totalRaised+=msg.value;
        emit contributed(msg.sender,msg.value);
    }

    function refund() public {
        require(block.timestamp>=deadline,unicode"尚未结束");
        require(totalRaised<goal,unicode"众筹已成功");
        uint amount=balances[msg.sender];
        amount=balances[msg.sender];
        payable(msg.sender).transfer(amount);
        emit refunded(msg.sender,amount);
    }

    function withdraw() public {
        require(block.timestamp>=deadline,unicode"尚未结束");
        require(totalRaised>=goal,unicode"众筹失败");
        require(msg.sender==owner,unicode"无权限");
        uint amount=address(this).balance;
        payable(owner).transfer(amount);
        emit withdrawed(owner,amount);
    }

    function gettimeLeft() public view returns(uint){
        require(block.timestamp<=deadline,unicode"已截止");
        return deadline-block.timestamp;
    }
    
}
*/