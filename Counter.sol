// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Counter {
    uint public count=0;

    function increment() public {
        count+=1;
    }
    function decrement() public{
        require(count>0, unicode"计数不能为负");
        count-=1;
        }
    }
//count属于状态变量，状态变量必须定义在合约内部，因为外部没有上下文存储位置
//声明函数时需要声明可见性
//require使用时，抛出错误问题时，中文需要在前面写unicode的显式说明，否则报错，英文不用
//相比于if requir更简洁，可以直接抛出错误问题，并且消耗更少的gas