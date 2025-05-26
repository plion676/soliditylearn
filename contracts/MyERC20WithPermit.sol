// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyERC20WithPermit is ERC20{
    mapping(address=>uint) public nonces;
    bytes32 public immutable DOMAIN_SEPARATOR;

    bytes32 public constant PERMIT_TYPEHASH = keccak256(
    "Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"
);
//类型哈希，将需要输入的类型转化成哈希值


    constructor(string memory name,string memory symbol) 
    ERC20(name,symbol){
        uint chainId;
         assembly {
            chainId := chainid()
        }
        DOMAIN_SEPARATOR=keccak256(//分隔不同代币，版本，链，合约
            abi.encode(
                keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"),
                //开始写的是PERMIT_TYPEHASH，这是隔开链，合约等，不应用TYPEHASH
                keccak256(bytes(name)),
                keccak256(bytes("1")),
                chainId,
                address(this)
            )

        );
    }

     function mint(address to, uint256 amount) external {
        _mint(to, amount);
     }
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external {
        require(block.timestamp<=deadline,"Expired");
        bytes32 digest=keccak256(abi.encodePacked//digest需要用encodePacked，需要符合EIP-712 的 EIP712Domain 结构
            ("\x19\x01",
            DOMAIN_SEPARATOR,
            keccak256(abi.encode(
                PERMIT_TYPEHASH,
                owner,
                spender,
                value,
                nonces[owner]++,
                deadline
                
              ))
            )
        );

        address recover=ecrecover(digest, v, r, s);
        require(recover!=address(0)&&recover==owner,"Invalid signature");
        _approve(owner,spender,value);
    }
    
    function debugDigest(
    address owner,
    address spender,
    uint256 value,
    uint256 deadline
) public view returns (bytes32) {
    return keccak256(abi.encodePacked(
        "\x19\x01",
        DOMAIN_SEPARATOR,
        keccak256(abi.encode(
            PERMIT_TYPEHASH,
            owner,
            spender,
            value,
            nonces[owner],
            deadline
        ))
    ));
}

}



DOMAIN_SEPARATOR=keccak256(
            abi.encode(
                keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"),
                keccak256(bytes(name)),
                keccak256(bytes("1")),
                chainId,
                address(this)
