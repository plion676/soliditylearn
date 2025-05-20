// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Crowfunding {
    address public owner;
    uint deadline;
    mapping(address=>uint)public contributions;
    uint public goal;
    uint public totalRaised;
    event contributed(address contributor,uint amount);
    event Withdrawn(address owner,uint amount);
    event Refunded(address contributor,uint amount);
    constructor(uint _goal,uint durationInSeconds) {
        owner=msg.sender;
        goal=_goal;
        deadline=block.timestamp+durationInSeconds;
    }
    function contribute() public payable{
        require(block.timestamp<=deadline,unicode"已截止");
        require(msg.value>0,unicode"捐赠金额需大于0");
        contributions[msg.sender]+=msg.value;
        totalRaised+=msg.value;
        emit contributed(msg.sender,msg.value);
    }
    function withdraw() public{
        require(block.timestamp>=deadline,unicode"众筹未结束");
        require(totalRaised>=goal,unicode"众筹已失败");
        require(msg.sender==owner,unicode"无权限");
        uint amount=address(this).balance;
        payable(owner).transfer(amount);
        emit Withdrawn(owner,amount);
    }
    function refund() public {
        require(block.timestamp>=deadline,unicode"未结束");
        require(totalRaised<goal,unicode"目标已达成");
        uint amount=contributions[msg.sender];
        require(amount>0,unicode"未捐赠");
        payable(msg.sender).transfer(amount);
        emit Refunded(msg.sender,amount);
    }

    function getTimeLeft()public view returns(uint) {
        if(block.timestamp>deadline){
            return 0;
        }
        return deadline-block.timestamp;
    }
    
}
//注意各函数时间戳，目标等逻辑
