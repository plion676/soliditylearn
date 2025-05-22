// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IPoolAddressesProvider, IPool, IFlashLoanSimpleReceiver,IERC20} from "./interfaces.sol";

contract FlashLoanDemo is IFlashLoanSimpleReceiver {
    IPoolAddressesProvider public immutable ADDR_PROVIDER;
    IPool public immutable POOL;

    constructor(address provider) {
        ADDR_PROVIDER = IPoolAddressesProvider(provider);//创建地址提供者
        POOL = IPool(ADDR_PROVIDER.getPool());//连接Aave流动性池
    }

    function requestFlashLoan(address asset,uint amount) external {
        POOL.flashLoanSimple(
        address(this),
        asset,
        amount,
        "",
        0
        );
    }//主要就是选择代币和数额，找池子要
    function executeOperation(
        address asset,
        uint256 amount,
        uint256 premium,
        address initiator,
        bytes calldata params
    ) external override returns(bool){
        uint total = amount+premium;
        IERC20(asset).approve(address(POOL),total);
        return true;
        }//主要实现函数，里面加入要执行的其他合约，完成之后，通过approve授权还款，还款失败就会回滚，整个过程都失效
    }
    //也是第一次搞这种调用其他接口的合约，其实大差不差
    //测试网的水根本领不到啊，写写合约得了
  