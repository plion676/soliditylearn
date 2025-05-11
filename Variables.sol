// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Variables {
    uint public number = 42;
    string public text = "Test";
    address public user = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    
    function updateNumber(uint newnumber) public{
        if(newnumber>0) {
            number = newnumber;
        }
    }

    function getNumber() public view returns (uint) {
        return number;
}

}

