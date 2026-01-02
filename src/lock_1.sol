// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IERC20} from "node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract lock1 {

      event  depositevent(address indexed from, address indexed to, uint256 indexed amount) ;

    address token_address;
    address relayer_address;
    uint256 public total_amount;

    mapping(address=>uint256) public people_deposit;
    mapping(address=>uint256) public people_pending;


    constructor(address tokid,address relayer_id){

        token_address =tokid;
        relayer_address=relayer_id;


    }


    function deposit(uint256 amount) public{

        require(IERC20(token_address).allowance(msg.sender,address(this)) >=amount);

        people_deposit[msg.sender] += amount;

        total_amount+=amount;

        IERC20(token_address).transferFrom(msg.sender,address(this),amount);

        emit depositevent(msg.sender,address(this),amount);




    }


    function withdraw( uint256 amount) public{

        require(people_pending[msg.sender]>=amount);

        people_pending[msg.sender] -=amount;
        total_amount-=amount;


        IERC20(token_address).transfer(address(msg.sender),amount);

    }

    function burn_on_otherside(address id, uint256 amount) public{
        require(msg.sender==relayer_address,"unautorised caller not a registered relayer");

        people_pending[id] +=amount;
        


    }
}





