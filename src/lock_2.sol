// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IERC20} from "node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";


interface token2{
    function mint(address id ,uint256 amount) external;
    function burn(address id ,uint256 amount) external;
}


contract lock2{

    address public  token_address2;

    uint256 total_amount;
    mapping(address=>uint256) public people_pending;

    event burn_event(address indexed id, uint256 indexed amount );

    constructor(address tokenid){
        token_address2=tokenid;
    }



    function withdraw(uint256 amount) public {

        require(people_pending[msg.sender]>=amount ,"not enough funds");
        people_pending[msg.sender]-=amount;
        

        token2(token_address2).mint(address(msg.sender),amount);



          
    }

    function burntoken(uint256 amount) public {

        require(IERC20(token_address2).allowance(address(msg.sender),address(this))>=amount);

        IERC20(token_address2).transferFrom(address(msg.sender),address(this),amount);


        token2(token_address2).burn(address(this),amount);



        emit burn_event(address(msg.sender),amount);
    }
    

    
    function locked_otherside(address id,uint256 amount)public {

        people_pending[id] +=amount;
       

    }
}