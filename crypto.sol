// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CryptoCoin{
    address public minter;
    mapping (address=>uint) public balances;

    constructor() {
        minter = msg.sender;
    }

    function mint(address receiver, uint amount) public {
        // if the given address matches the minter then only the function will continue
        require(msg.sender == minter);
        balances[receiver] = balances[receiver] + amount;
    }

    error InsufficientBalance(uint req, uint available);

    function send(address receiver, uint amount) public {
        // checking if the amount to be sent is in the account or not
        if (amount > balances[msg.sender]){
            // if the amount to be sent is more, it throws an error
            revert InsufficientBalance({
                req: amount,
                available: balances[msg.sender]
            });
        }

        balances[msg.sender] = balances[msg.sender] - amount;
        balances[receiver] = balances[receiver] + amount;
    }
}
