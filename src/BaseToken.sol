// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";

contract BaseToken is ERC20, AccessControl, Pausable {
    mapping(address => bool) public isBlackListed;

    bytes32 public constant OWNER_ROLE = keccak256("OWNER_ROLE");

    // Custom Errors
    error InvalidAmount();
    error AddressBlacklisted(address account);

    constructor() ERC20("Base", "BASE") {
        _mint(msg.sender, 1000 * 10 ** decimals());
        _grantRole(OWNER_ROLE, msg.sender);
    }

    // @dev Mint new tokens to a specified address.
    function mint(address to, uint256 amount) public onlyRole(OWNER_ROLE) {
        if (to == address(0)) {
            to = msg.sender;
        }

        if (amount == 0) {
            revert InvalidAmount();
        }
        _mint(to, amount);
    }

    // @dev Burn tokens from the caller's account.
    function burn(uint256 amount) public onlyRole(OWNER_ROLE) {
        if (amount == 0) {
            revert InvalidAmount();
        }
        _burn(msg.sender, amount);
    }

    // @dev Pause token transfers.
    function pause() public onlyRole(OWNER_ROLE) {
        _pause();
    }

    // @dev Unpause token transfers.
    function unpause() public onlyRole(OWNER_ROLE) {
        _unpause();
    }

    // @dev blacklist an address.
    function setBlacklist(address user) public onlyRole(OWNER_ROLE) {
        require(user != address(0), "Invalid address");

        isBlackListed[user] = true;
    }

    // @dev remove from blacklist an address.
    function removeFromBlacklist(address user) public onlyRole(OWNER_ROLE) {
        require(user != address(0), "Invalid address");

        isBlackListed[user] = false;
    }

    // Override transfer functions to implement pause and blacklist
    function _update(
        address from,
        address to,
        uint256 amount
    ) internal override whenNotPaused {
        if (isBlackListed[from]) {
            revert AddressBlacklisted(from);
        }
        if (isBlackListed[to]) {
            revert AddressBlacklisted(to);
        }

        super._update(from, to, amount);
    }
}
