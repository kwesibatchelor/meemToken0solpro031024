// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MEEM is ERC20, Ownable {
    uint256 private constant INITIAL_SUPPLY = 10000000 * 10**18;

    constructor(address initialOwner) ERC20("MEEM", "ME") Ownable(initialOwner) {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function distributeTokens(address distributionWallet) external onlyOwner {
        uint256 supply = balanceOf(msg.sender);
        require(supply == INITIAL_SUPPLY, "Tokens already distributed");

        // add reentrancy guard
        require(!inDistribution, "Distribution in progress");
        inDistribution = true;

        _transfer(msg.sender, distributionWallet, supply);

        inDistribution = false;
    }

    // add reentrancy guard variable 
    bool private inDistribution;
}