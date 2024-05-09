// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    constructor(uint256 initialSupply) ERC20("MyToken", "MT") {
        _mint(msg.sender, initialSupply);
    }
}
