//SPDX-License-Identifier: q
pragma solidity ^0.8.0;
/*Storage: The varaible is (or is treated as) a state variable
Memory: The data is loaded onto memory
Calldata: Like memory, but can only be used for function inputs; can't be modified & therefore can be used to save gas (saves gas by skipping the copying step that would be performed if declared as memory)*/
contract dataLocations{
    struct MyStruct{
        uint foo;
        string txt;
    }
    mapping(address => MyStruct) public myStructs;
    function ejemplos() external{
        myStructs[msg.sender] = MyStruct({foo:123, txt:"bar"});
        MyStruct storage myStruct = myStructs[msg.sender];//Declare a struct as 'storage' whn you want to modify the struct
        myStruct.txt="foo";
        //MyStruct memory myStruct = myStructs[msg.sender]; <--If you just wanted to read data from this variable, then you can declare it as memory
        //myStruct.txt="fbr"; <--You can still write to the struct loaded onto memory, but after the function resolves, the changes will not be kept
    }
}
contract simpleStorage{
    string public text;

    function set(string calldata _text) external{
        text = _text;
    }
}