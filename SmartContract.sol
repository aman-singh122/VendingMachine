// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VendingMachine {

    uint soda;
    address owner;

    struct Customer {
        uint sodaCount;
        uint lastPurchased;
        bool vip;
    }


   mapping (address => Customer) public sodaPurchased;


    constructor() {
        soda = 100;
        owner = msg.sender;
    }

    function buy() public payable {
        require(msg.value == 1 ether, "You should have 1 ether");
        require(soda > 0, "Out of stock");
       
 Customer storage c1 = sodaPurchased[msg.sender];

c1.sodaCount++;

if (c1.sodaCount == 5)
    c1.vip = true;

c1.lastPurchased = block.timestamp;
        soda = soda - 1;
    }

    function fillSoda(uint _soda) public {
        require(msg.sender == owner, "You are not the owner");

        soda = soda + _soda;
    }

    function withdrawBalance() public {
        require(msg.sender == owner, "You are not the owner");

        payable(owner).transfer(address(this).balance);
    }
}