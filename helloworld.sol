// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract HelloWorld {

    string public greet="Hello World!"; //定义一个状态变量greet
      function getGreet() public view returns (string memory) {
        return greet;
    }//这段可写可不写，定义变量是public会自动为变量声明一个getter函数，用于查询变量
      function setGreet(string memory newgreet) public{
        greet=newgreet;
      }//改变greet的值，此时函数可见性不能是view，因为需要输入更改，view为只读
  //tese
}
