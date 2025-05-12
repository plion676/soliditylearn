// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Voting {
    mapping(string=>uint) public votes;
    mapping(address=>bool)public hasvoted;
    event voted(address voter,string candidate);
    function vote(string memory candidate) public{
        require(!hasvoted[msg.sender], unicode"您已投票");
        votes[candidate]=votes[candidate]+1;
        emit voted(msg.sender,candidate);
        hasvoted[msg.sender]=true;
    }    
    function getVotes(string memory candidate) view public returns(uint){
        return votes[candidate];
    }
}

//mapping后都需要加[]来表示具体的映射，总是会在hasvoted后面忘记[]