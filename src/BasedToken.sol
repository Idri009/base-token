// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract BasedToken is ERC20, AccessControl {
    bytes32 public constant OWNER_ROLE = keccak256("OWNER_ROLE");

    constructor() ERC20("BasedToken", "BT") {
        _mint(msg.sender, 1000 * 10 ** decimals());
        _grantRole(OWNER_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public onlyRole(OWNER_ROLE) {
        _mint(to, amount);
    }
}
