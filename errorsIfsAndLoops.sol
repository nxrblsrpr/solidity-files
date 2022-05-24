//SPDX-License-Identifier: sample text
pragma solidity ^0.8.0;

contract randomTings{
    uint public constant n = 0;
    uint public q;

//When returning strings in solidity, you must identify the return type as 'string memory' instead of just string

    function switchalizer() external pure returns (string memory){//Traditional if, else if, else syntax (you know how this works already)
        if(n < 0){
            return "how in tf?";
        }else if(n==0){
            return "okay, so it's zero";
        }else{
            return "third option";
        }
    }
    function sq(uint a) public pure returns (uint){//This function is purposefully assigned "public pure" instead of "external".
        return a*a;                                //It needs the 'public' keyword so that it can be called and used within another function
    }
    function swappalizer() external pure returns (string memory){//Basically the same thiing as above, but using a ternary operator
        return n < 0? "how in tf?" : "something else";
        /*So for this: 
        'return n < 0?' is the if statement
        'how in tf?' is the original return statement (like on line 11)
        ':' represents the 'else'
        'something else' is the return statement for the else part*/
    }
    function filler() external returns (uint){
        uint baw =0;
        for(uint i=0; i<10; i++){//As you can see, the for loop syntax is as expected
        if(q<0){
            continue; //When placed in a loop, this will skip an iteration as of the point it is encountered in runtime
        }else if(q==9){
            break; //Breaks out of the loop entirely, you know this man
        }
        q++;
        }
        while(baw < 6){//Basic while loop syntax
            return sq(q);
        }
        /*In other languages, loop duration is not a big deal; however you're coding in solidty now
        Remember that this stuff costs gas, the longer the loop goes on, the more gas the contract will need to execute*/
    }
    /*Error checking and stuff like that
    When an error is thrown, gas will be refunded and any state changes will be reverted
    Custom errors should be prioritized whrn possible; the long the error message (in other error checks), the more gas is used*/
        function req(uint g) public pure{
            require(g <10, "g >= 10");//The first part checks to see if a specified condition is met and if it is not met, the second part is the error message that will be thrown
            //Conventionally speaking, if the above error check passes (no error is thrown), then more code will exist following the above line of code
        }
        function rev(uint g) internal pure{
            uint f =99;
            f +=2;
            if(g<10){
                revert("g>=10");//Optimal to use particularly in nested if statements
            }
        }
        function asser() external view{
            assert(q==0);//Throws an error if the specified check is not met. 
            //The typical use for this is to see if you perhaps changed something that was meant to be kept the same. 
            //"Use 'assert' to check for conditions that should always be equal to true"
        }

        error myError(/*You can have error params in here if you want, not necessary though*/ /*address caller, uint g*/);//Uses less gas; MUST be used in tandem w/ the 'revert' error check
        function customError(uint g) external pure /*view*/{ //This needs the 'view' keyword if you want to use the global variable 'msg.sender'
            if(g<10){
                revert myError(/*msg.sender, g*/);//As you can see here, the revert is used but differently than before because everything is being passed from the custom error above
            }
        }
    /*You may notice that the functions have an assortment of initialization keywords:
    'external' means that the function can be called from an external contract, whether that be another contract within this .sol file or on the blockchain
    'internal' means that the function can only be called from within this contract and from child contracts
    'public' means that the function can be called by other functions inside the contract, outside the contract, and by children
    'private' means that the function can be called within the original contract
    'pure' means that the function is read-only, not making changes to any states and does not accept input from outside the scope of the function
    'view' means that the function is read-only, not making changes to any states but it does accept input from outside of the scope of the function*/
}
