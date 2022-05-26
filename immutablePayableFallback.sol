//SPDX-License-Identifier: q
pragma solidity ^0.8.0;

contract immutability{
    //The keyword 'immutable' makes it so that a variable can be initialized(or set ONLY ONCE) when a contract is deployed but cannot be changed afterwards. Kinda makes it so that it is like a constant
    //When an 'immutable' variable is called, it uses less gas than a mutable variable
    uint public immutable num = 88;
    //typically, 'immutable' variables are placed in a 'constructor'
}
contract commerce{
    //The 'payable' keyword allows for the sending & receiving of ETH. Addresses & functions can have the prefix
    address payable public moneybags;//Because of the 'payable' keyword, this variable can send ETH
    constructor(){
        moneybags = payable(msg.sender);
    }
    function deposit() external payable{}//When ETH is used to call a function, this statement will add that ETH to this contract's balance
    function getBal() external view returns(uint){
        return address(this).balance;//Keep in mind that 'this' serves as an external call to the operating contract. The '.balance' returns the amount of ETH (in wei) that this contract holds
    }
}

/*Fallback is a special function that gets called when the main function you 
intended to call doesn't exist inside the contract 
(E.g., you [externally] call 'sampleFunction()', and that doesn't exist within the referenced contract)
The main use of a fallback is to directly send ETH; enables the receiving 
of ETH by the smart contract containing the fallback function
The fallback is mostly used to receive the direct sending of ETH
If no 'fallback()' exists, then ig the call will just fail? (TEST THIS LATER)*/

contract payabull{
    event Log(string func, address sender, uint value, bytes data);
    fallback() external payable{//This will be defaulted to when msg.data (data that is sent) is not empty
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }
    receive() external payable{//'receive' is executed when the data that was sent is empty (low level interactions calldata)
        emit Log("receive", msg.sender, msg.value, "");
    }
}
/*fallback() or receive()?
    ETH sent to contract
                |
        is msg.data empty?
                /  \
            yes     no
            /          \
receive() exists?      fallback()
        /   \
      yes    no
      /       \
receive()      fallback()

If 'receive()' exists & 'msg.data' is not empty, receive will be executed
!!!A contract can receive 0 ETH upon execution; internalize it that a contract always receives an amount of ETH*/
