// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract Pip is ERC20 ,Ownable {

    string token_name;
    string token_symbol;
    uint256 total_amount;

    event minting(address indexed to,uint amount);


    constructor( string memory name,string memory symbol) ERC20(name,symbol) Ownable(msg.sender){

        token_name=name;
        token_symbol=symbol;
    }

    function mint( address id,uint256 amount) public{

        _mint(id,amount);

        total_amount+= amount;

       emit minting(id,amount);


    }

    function balance(address id) public view returns(uint256){

        return balanceOf(address(id));
    }

function namefun()  public view returns(string memory){
    return token_name;
}


function symbolfun()  public view returns(string memory){
    return token_symbol;
}
   
}
