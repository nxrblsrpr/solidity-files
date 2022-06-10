//SPDX-License-Identifier: q
pragma solidity ^0.8.0;

contract testContract{
    uint public x;
    uint public value = 23;
    function setX(uint _x)external{
        x = _x;
    }
    function getX()external view returns(uint){
        return x;
    }
    function setXandReceiveEther(uint _x)external payable{
        x = _x;
        value = msg.value;//Sent ETH will be stored in 'value'
    }
    function getXandValue()external view returns(uint, uint){
        return (x, value);
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
    function setXandSendEther(testContract _test, uint _x)external payable{
        _test.setXandReceiveEther{value: msg.value}(_x);
    }
    function getXandValue(address _test)external view returns(uint, uint){
        (uint x, uint value) = testContract(_test).getXandValue();
        return (x, value);
        //(x, value) = testContract(_test).getXandValue(); If you mention the return vars in the function declaration, then you can use this one liner instead of the two lines above
    }
}