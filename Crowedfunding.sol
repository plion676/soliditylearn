// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Crowfunding {
    uint deadline;
    constructor(uint durationInSeconds) {
        deadline=block.timestamp+durationInSeconds;
    }
    function getTimeLeft()public view returns(uint) {
        if(block.timestamp>deadline){
            return 0;
        }
        return deadline-block.timestamp;
    }
    
}