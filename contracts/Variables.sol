// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Variables {
    uint public number = 42;
    string public text = "Test";
    address public user = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    
    function updateNumber(uint newnumber) public{
        if(newnumber>0) {
            number = newnumber;
        }//更改number，函数内部变量无需memory位置定义，因为uint(byte32,address,boll,int)是直接存储具体值的值类型，string等引用类型才需要
    }

    function getNumber() public view returns (uint) {
        return number;
}

}

