// SPDX-License-Identifier: None lol
pragma solidity ^0.8.13;

/*
Basic counter app thing or whatever. Allows for manual incrementation & resetting
We've learned here that the keywords "view" & "pure" are READ ONLY modifiers for functions
Therefore, the contract won't compile if those keywords are thrown into any of the function definitions
This happens because the '=' operand changes the state of a variable (which happens to be a state variable in this case)
*/

contract helloWorld{
    uint public ctr = 0;
    function increment() external returns (uint){
        return ctr+=1;
    }
    function reset() external{
        ctr=0;
    }
}
