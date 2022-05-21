//SPDX-License-Identifier: nonexistent
pragma solidity ^0.8.13;
/*ENTIRE CONTRACT MUST CONSIST OF STATE VARS, GLOBAL VARS, FUNCTION MODIFIERS, FUNCTIONS, & ERROR HANDLING*/
contract ownable{
    //Here are the state variables
    address public owner;
    address public zeroAddress=address(0);

    constructor(){//The constructor initializes a state variable when the contract is deployed
        owner=msg.sender;
    }

    modifier yoS(){//This modifier checks to see if the current user is the owner; an error will be thrown if the current user is not the owner of the contract
        require(msg.sender == owner, "Nah, not yours");//This is the error message that will be thrown
        _;
    }
    function genWit() external view yoS{//This function can only be called by the contract owner
        //placeholder line of code that would send money to whowever the owner is but idk how to do that yet
        assert(1 wei == 1);//This is literally a check to see if 1 wei is 1 wei, filler code
                            /*In solidity, currency denominations are measured in wei, consider that you can evaluate USD by the cents/pennies; E.g., $100 is 10000 cents
                            ETH currency denominations are as follows:
                            1 wei == 1 (or 10^-18 ETH)                      (in solidity syntax: 1)
                            1 gwei == 1000000000 (or 10^-9 ETH)             (in solidity syntax: 1e9)
                            1 ether == 1000000000000000000 (or 1 ETH)       (in solidity syntax: 1e18)*/
    }
    function newOwnership(address newOwner) external yoS{//This function can only be called by the contract owner
        if(newOwner == zeroAddress){//If the newOwner param is given a 0 address (0x0...)
            revert nonZero(msg.sender);//Throw an error referencing the custome error "nonZero"
        }
        owner=newOwner;//If nothing goes wrong, change the owner to whoever's address is entered for the param for this function        
    }
    error nonZero(address ownr);//Throw an error of the type address (referencing the address of the accessor)
}