//SPDX-License-Identifier: q
pragma solidity ^0.8.0;
//Using '.call' to call functions in other contracts
contract testCall{
    string public message;
    uint public x;
    event Log(string message);
    
    fallback()external payable{
        emit Log("fallback was called");
    }
    function fun1(string memory _message, uint _x)external payable returns(bool, uint){
        message = _message;
        x = _x;
        return (true, 999);
    }
}
contract Call{
    bytes public data;

    function callFun1(address _test)external payable{//'_test' will represent the address of the contract that is to be referenced for calling functions
    //This function must be made payable so that ETH can be sent to it (for 'value' in line 24)
        //When using call, you must initialize the params for bool & bytes. You can add 'value' in '{braces}'. You can also add 'gas' to specify an amount of gas to send to the called referenced contract to call the function
        (bool success, bytes memory _data) = _test.call{value: 111/*, gas: 5000*/}(//'value' specifies the amount of wei that MUST be sent in order for the function to get called
            abi.encodeWithSignature(//'abi.encodeWithSignature' is essential for referencing/sending params to another contract
                "fun1(string,uint256)", "call fun1", 123//You can see here that the referenced function is in quotes (THIS PART IS NOT TO BE TREATED AS A COMMON STRING, THE SYNTAX & SPACING MATTERS A LOT!) 
            )                                           //and then after that, the params are input
        );//Things do not have to be spaced out across different lines like this, but ig that is how this is conventionally coded
        require(success, "call failed");
        data = _data;
    }
    function callDoesNotExist(address _test)external{//This function does not need to be made payable because no ETH will be used at all here
       (bool success, ) = _test.call(abi.encodeWithSignature("funcNonexistent()"));//This makes a call to a nonexistent function w/o sending any data
       require(success, "call failed");
    }//Because the call attempt to a function fails, an error will be thrown HOWEVER, because the referenced function has a 'fallback()', the 'fallback()' will get triggered and there will not be a general failure, the EVM will see it as a success (therefore, no gas is refunded)
}