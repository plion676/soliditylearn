// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyERC20WithPermit is ERC20{
    mapping(address=>uint) public nonces;
    bytes32 public immutable DOMAIN_SEPARATOR;

     // keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
    bytes32 public constant PERMIT_TYPEHASH = 0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9;

    constructor(string memory name,string memory symbol) 
    ERC20(name,symbol){
        uint chainId;
         assembly {
            chainId := chainid()
        }
        DOMAIN_SEPARATOR=keccak256(
            abi.encode(
                PERMIT_TYPEHASH,
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
        bytes32 digest=keccak256(abi.encode
            ("\x19\x01",
            DOMAIN_SEPARATOR,
            keccak256(abi.encode(
                PERMIT_TYPEHASH,
                owner,
                spender,
                value,
                deadline,
                nonces[owner]++
              ))
            )
        );

        address recover=ecrecover(digest, v, r, s);
        require(recover!=address(0)&&recover==owner,"Invalid signature");
        _approve(owner,spender,value);
    }
}