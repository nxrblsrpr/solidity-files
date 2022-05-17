//SPDX-License-Identifier: ll
pragma solidity ^0.8.13;

contract funcModifier{
    address public owner;//State variable that's only here for the constructor
    uint public SAMPLE_CONSTANT;//State variable that's only here for the constructor

    constructor(uint a){//A constructor is a function that is only called once, when the contract is being deployed
        owner=msg.sender;
        SAMPLE_CONSTANT = a; 
        //You can use a constructor as a way to initialize all of your state variables at the deployment of the contract
    }

    function fun1() external view returns (uint){
        return SAMPLE_CONSTANT;
    }
    modifier asdf (uint a){//Function modifiers can be seen as a "wrapper" to existing functions, they allow for the reuse of code before and/or after functions execute
        //a-4;
        a+=16;
        _;//This is a very important part of the syntax, letting the compiler know that the rest of
    }     //the wrapped function's code should be executed after the above line(s) execute(s)
    function fun2(uint a) external pure asdf(a) returns (uint){//Notice here how the modifier is appended to the function's initialization
        return a+a;
    }
    modifier sandwich(){
        //Code can be placed here
        _;//This would execute the code of the wrapped function
        //After the code of the wrapped function is executed, you can have more code here that would execute
    }
    //Also as of recently, you've started to notice a bit of a pattern with the naming convention of variables
    //having an '_' in front of thee, like this: '_addr, _n, _total'. What's that all about?
}