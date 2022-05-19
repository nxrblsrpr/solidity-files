//SPDX-License-Identifier: hogs breath
pragma solidity ^0.8.0;
//Consider mapping to be similar to dictionaries (in python); allows for efficient lookup
contract mappings{
    mapping(address => uint) public balance;//This is an example of simple mapping. This connects an address to a value; INTERPRETATION: You can consider this as an equivalent to checking for balances
    mapping(address => mapping(address => bool)) public isConnected;//This is an example of nested mapping. This checks two addresses concurrently and sees if there is a connection; INTERPRETATION: You can consider this as an equivalent to see if addresses are somehow related
    mapping(uint => address) public userAcct;//Another example of a simple mapping. This connects a value to an address; INTERPRETATION: You can consider this as an equivalent to checking for the address of a specific userID
     
    function example() external{
        balance[msg.sender]=56;//"The balance of 'msg.sender' is equal to 56"; This is how to set a mapping
        uint curBal = balance[msg.sender];//This is how to retrieve the value from a mapping
        address na = userAcct[27];//This would retrieve the value from this mapping however, the queried value for the mapping does not exist yet

        balance[msg.sender] +=21;//Adds '21' to the balance of 'msg.sender'; This is a way to update a mapping. Ofc, you can always change the value entirely (E.g., 'balance[msg.sender] = 47;')
        delete balance[msg.sender];//Resets the mapping value to default. In this case, the default value of a 'uint' is 0, so the mapping 'balance[msg.sender]' will return 0
        
        isConnected[address(5)][address(55)] = true;//"'address(5)' & 'address(55)' ARE in relation to each other"
        delete isConnected[address(5)][address(55)];//The default value for a boolean is 'false'
    }
    //Iterable Mapping: The purpose of this is to check if certain values exist within a mapping but via an iterable means; you need an improv array to do this
    mapping(address => bool) public inserted;//INTERPRETATION: You can consider this as a way to check if an address is present
    address[] public keys;//Just an array of address keys

    function set(address _key, uint _val) external{
        balance[_key] = _val;//Sets a pairing into the mapping/Updates the balances mapping
        if(!inserted[_key]/*If the address key is not yet inserted...*/){//Checks if an address is newly inserted and if it is, then the value will be appended to the array of keys
            inserted[_key]=true;/*Changes the key insertion to true...*/
            keys.push(_key);/*adds the key to the array*/
        }
    }
    function getSize() external view returns(uint){//Simply meant to get the size of the 'balance' mapping
        return keys.length;
    }
    function first() external view returns(uint){//Simply meant to get the first address key that was inserted
        return balance[keys[0]];
    }
    function last() external view returns(uint){//Simply meant to get the last address key that was inserted
        return balance[keys[keys.length-1]];
    }
    function get(uint _i) external view returns(uint){//Meant to get any address key in the entire mapping. So you can put this function into a loop and set the param to whatever var you would have that iterates; this would retrieve the corresponding value from the mapping
        return balance[keys[_i]];
    }
}