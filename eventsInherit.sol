//SPDX-License-Identifier: q
pragma solidity ^0.8.0;
//Events allow for data to be written on the blockchain; this data can't be retrieved later by a smart contract. The main purpose of an 'event' is to log that something happened
//Using an event may be a cheaper option than storing data as state variables
contract events{
    event Log(string message, uint val);
    event IndexedLog(address indexed sender, uint val);//The 'indexed' keyword allows for log searching by param; up to 3 params can be indexed
    function ejemplo() external{
        emit Log("sample text", 54);//'emit' is used to trigger an event(?); Consider 'event' to be the function declaration, and 'emit' to be the function call
        emit IndexedLog(msg.sender, 45);
    }
    event Message(address indexed _from, address indexed _to, string message);
    function sendMessage(address _to, string calldata message) external{//You'll have to pay for every message that you send
        emit Message(msg.sender, _to, message);
    }
}
//The above function is an expensive way to send messages to other addresses (or smart contracts), but it works quite well for all intents & purposes

//Inheritance: Allows for the use of another contract's functions

contract con1{
    function fun1()public pure virtual returns(string memory){//'virtual' This function can be customized by a child contract
        return "text a";
    }
    function fun2()public pure virtual returns(string memory){
        return "text b";
    }
    function fun3()public pure returns(string memory){
        return "text c";
    }
    function fun4()internal virtual pure returns(string memory){//Because this function has the 'internal' keyword, it can be inherited & accessed from outside of this contract, but not called on the blockchain
        return "text d";
    }
    function fun5()external virtual pure returns(string memory){
        return "text e";
    }
    function fun6()private pure returns(string memory){//Because of the 'private' keyword, this function can ONLY be used within this contract and cannot be used w/ the 'virtual' keyword
        return "text f";
    }
}
contract con2 is con1{
    function fun1()public pure override returns(string memory){//'override' This function comes from an inherited contract and can be customized
        return "text ab";
    }
    function fun2()public pure virtual override returns(string memory){//With both virtual & override, you can make it so that this function can be passed
        return "text ba";
    }
    function fun4()internal override pure returns(string memory){//This 'internal' function is overriden from 'con1', but it cannot be accessed by other contracts unless it is made virtual
        return "text dd";
    }

    /*Even though 'fun3' in 'con1' is not declared as 'virtual', it can still be inherited. 
    It cannot be customized though. If you attempted to place it within this contract, an error 
    would be thrown referring to the fact that it is not overridden. If you did slide in the 'override' keyword, 
    an error would still be thrown (within the original contract) mentioning that it is not a 'virtual' function and that it is attempting to be overridden*/
}
contract con3 is con2{//Because 'con2' inherits 'con1', this contract has access to all of 'con1's available functions
    function fun7() public pure virtual returns(string memory){
        return "text bac";
    }
}

contract con4 is con3{}//Same deal as above

//Multiple Inheritances
//Order of inheritance: Goes from most base-like to derived. The contract that is most base-like is the contract that inherits the least.
//You need to review the concept in order to get a firm grasp of this
//Try to avoid multiple inheritance when you're working w/ a whole bunch of contracts. Especially if they inherit each other

contract con5 is con3, con4{
    function fun2()public pure override returns(string memory){
        return "text a";
    }
    function fun7()public pure override returns(string memory){
        return "text b";
    }
}
