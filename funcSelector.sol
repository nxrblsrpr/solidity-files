//SPDX-License-Identifier: q
pragma solidity ^0.8.10;

contract Receiver{
    event Log(bytes data);
    function transfer(address _to, uint _amount)external{
        emit Log(msg.data);
        /*Executing this function will return the following:
        0xa9059cbb --> This is the function that was called ([bytes4] in encoded form, a.k.a. "function selector")
        0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4 --> This is the first function param that was passed to the function
        0000000000000000000000000000000000000000000000000000000000000008 --> This is the second function param that was passed to the function (in hex)
        */
    }
    function funcSelector(string calldata _func) external pure returns(bytes4){//This will return "0xa9059cbb", if you enter ""transfer(address,uint256)""
        return bytes4(keccak256(bytes(_func)));//by passing the function header to this, you should be able to get the "function selector" for the above function
    }//The above return statement gets the keccak256 hash of the input and then cuts everything after the first 4 bytes
}