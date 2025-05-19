// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract MiniAMM {

    uint public xReserve;
    uint public yReserve;
    function init(uint X,uint Y) public{
        xReserve=X;
        yReserve=Y;
    }
    function swapXforY(uint amount)public view returns(uint dy){
        uint newX=xReserve+amount;
        uint newY=xReserve*yReserve/newX;
        require(newY>=yReserve/5, unicode"Y代币余量不足以兑换");
        dy=yReserve-newY;
    }
    
}