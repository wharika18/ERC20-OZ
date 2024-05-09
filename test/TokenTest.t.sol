// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {Test} from "forge-std/Test.sol";
import {DeployToken} from "../script/DeployToken.s.sol";
import {Token} from "../src/Token.sol";
import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract OurTokenTest is Test {
    Token public token;
    DeployToken public deployer;
    address USER1 = makeAddr("USER1");
    address USER2 = makeAddr("USER2");
    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployToken();
        token = deployer.run();

        vm.prank(msg.sender);
        token.transfer(USER1, STARTING_BALANCE);
    }

    function testBalance() public {
        assertEq(STARTING_BALANCE, token.balanceOf(USER1));
    }

    function testAllowance() public {
        vm.prank(USER1);
        token.approve(USER2, 20);
        assertEq(token.allowance(USER1, USER2), 20);
    }

    function testTransfer() public {
        vm.prank(USER1);
        token.transfer(USER2, 30);
        assertEq(token.balanceOf(USER2), 30);
    }

    function testTransferFrom() public {
        vm.prank(USER1);
        token.approve(USER2, 20);

        vm.prank(USER2);
        token.transferFrom(USER1, USER2, 10);
        assertEq(token.balanceOf(USER2), 10);
    }
}
