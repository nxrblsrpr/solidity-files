//SPDX-License-Identifier: q
pragma solidity ^0.8.0;
//REVISIT THIS [https://www.youtube.com/watch?v=6aQErpWPLbk&list=PLO5VPQH6OWdVQwpQfw9rZ67O6Pjfo6q-p&index=41]
contract testContract{
    uint public x;
    uint public value = 23;
    function setX(uint _x)external{
        x = _x;
    }
    function getX()external view returns(uint){
        return x;
    }
}
contract callTest{
    //function setX(address _test, uint _x)external{    This line would first pass the address of a contract
    //    testContract(_test).setX(_x);                 This line would initialize the contract after the address has been passed
    
    function setX(testContract _test, uint _x)external{//What this does instead is simply get the address of the test contract & initialize a variable as the address at once
        _test.setX(_x);//The initialized contract address can be called here
    }
    function getX(testContract _test)external view returns(uint x){
       x = _test.getX();
       //return x; Because 'x' was declared as the return variable in the function decalration, no explicit return statement is necessary
    }
}