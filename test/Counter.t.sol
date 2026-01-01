// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Pip} from "../src/pip.sol";
import {Tpip} from "../src/tpip.sol";
import {lock1} from "../src/lock_1.sol";
import {lock2} from "../src/lock_2.sol";

contract CounterTest is Test {
    Pip public p;
    Tpip public t;
    lock1 public l1;
    lock2 public l2;

    address deployer=0xBF39a3a330F9774FBBd6c53f7D8ff91bB03479DE;
    address user=0x1111111111111111111111111111111111111111;
    address relay=0x2222222222222222222222222222222222222222;


    function setUp() public {

        vm.startPrank(deployer);
        p = new Pip("pip","p");

        l1= new lock1(address(p));

        t= new Tpip("Tpip","t");

        l2= new lock2(address(t));

        t.transferOwnership(address(l2));

        vm.stopPrank();


    }




    function testdeposit() public {

        vm.startPrank(user);
        p.mint(user,1000);

      p.approve(address(l1), 500);

        assertEq(p.balance(user),1000);

        vm.expectEmit(true,true,true,false);
       emit lock1.depositevent(user,address(l1),500);

        l1.deposit(500);
        assertEq(l1.total_amount(),500);
        assertEq(l1.people_deposit(address(user)),500);

    }

    function testl2() public {

         vm.startPrank(user);
        p.mint(user,1000);

      p.approve(address(l1), 500);

        assertEq(p.balance(user),1000);

        vm.expectEmit(true,true,true,false);
       emit lock1.depositevent(user,address(l1),500);

        l1.deposit(500);
        assertEq(l1.total_amount(),500);
        assertEq(l1.people_deposit(address(user)),500);
        vm.stopPrank();

        vm.prank(relay);
        l2.locked_otherside(user,500);

        vm.startPrank(user);

        assertEq(l2.token_address2(),address(t));

        assertEq(l2.people_pending(user),500);

        l2.withdraw(250);

        assertEq(t.balance(user),250);



    }


    function testburn()public{
            vm.startPrank(user);
        p.mint(user,1000);

      p.approve(address(l1), 500);

        assertEq(p.balance(user),1000);

        vm.expectEmit(true,true,true,false);
       emit lock1.depositevent(user,address(l1),500);

        l1.deposit(500);
        assertEq(l1.total_amount(),500);
        assertEq(l1.people_deposit(address(user)),500);
        vm.stopPrank();

        vm.prank(relay);
        l2.locked_otherside(user,500);

        vm.startPrank(user);

        assertEq(l2.token_address2(),address(t));

        assertEq(l2.people_pending(user),500);

        l2.withdraw(250);

        assertEq(t.balance(user),250);

        vm.startPrank(address(user));
        t.approve(address(l2),125);

       vm.expectEmit(true,true,false,false);
        emit lock2.burn_event(user,125);
        l2.burntoken(125);

        vm.stopPrank();

        vm.prank(relay);
        l1.burn_on_otherside(user,125);

        vm.startPrank(user);

        assertEq(l1.people_pending(user),125);
        assertEq(p.balance(user),500);

        l1.withdraw(125);

         assertEq(p.balance(user),625);








    }
}
