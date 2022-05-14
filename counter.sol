// SPDX-License-Identifier: None lol
pragma solidity ^0.8.13;

/*
Basic counter app thing or whatever. Allows for manual incrementation & resetting
We've learned here that the keywords "view" & "pure" are READ ONLY modifiers for functions
Therefore, the contract won't compile if those keywords are thrown into any of the function definitions
This happens because the '=' operand changes the state of a variable (which happens to be a state variable in this case)
*/

contract counter{
    uint public ctr = 0;
    function increment() external returns (uint){
        return ctr+=1;
    }
    function reset() external{
        ctr=0;
    }
    /*Default Values
    bool public b; //Booleans are false by default
    uint public u; //Unsigned Integers are 0 by default
    int public i; //Signed Integers are 0 by default
    address public a; //Addresses use the 0 address by default (40 zeroes 0x0000000000000000000000000000000000000000)
    bytes32 public b32; //Bytes32 uses a similar variant of the 0 address (64 zeroes 0x0000000000000000000000000000000000000000000000000000000000000000)*/
}
