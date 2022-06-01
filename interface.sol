//SPDX-License-Identifier: q
pragma solidity ^0.8.0;

/*contract counter{
    uint public count = 0;
    function increment() external returns (uint){
        return count+=1;
    }
    function decrement() external returns (uint){
        return count-=1;
    }
    function reset() external{
        count=0;
    }
}*/

//Interfaces work nicely if the contract that the interface is made for exists on the blockchain
//Interfaces make it pretty easy to call functions & access variables that exist in other contracts
//Be wary of the fact that in order to have an implementation of an interface work properly, all the referenced functions & variables must be EXACTLY the same

interface Icounter{//Based on standard naming conventions, the name of an 'interface' always begins w/ a capital I
    function count() external view returns(uint);//For functions in an interface, drop the extra '{}' stuff and just end it w/ a semi-colon
    function increment() external returns(uint);
    function decrement() external returns(uint);
}
//The above is an interface made for the 'counter' contract

contract callInterface{
    uint public count;
    function examples(address _counter)external{
        Icounter(_counter).increment();
        count = Icounter(_counter).count();
    }
}