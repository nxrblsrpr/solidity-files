//SPDX-License-Identifier: eh
pragma solidity ^0.8.0;
//I don't understand any of this rn, so I'll just come back to it later after I've gone over some other concepts to fortify my understanding
contract uno{//This contract functions like the 'Ownable' contract; basically allows for change of ownership
    address public owner = msg.sender;
    function setOwner(address _owner)public{
        require(msg.sender == owner, "you're not the owner");
        owner = _owner;
    }
}
contract dos{//Just initializes some values?
    address public owner;
    uint public value = msg.value;//Checking the value of this variable will show you how much ETH was sent to the contract
    uint public x; uint public y;
    constructor(uint _x, uint _y)payable{//'payable' means that ETH can be sent to this constructor
        x = _x;
        y = _y;
    }
}
contract tres{//The point of this is to allow for the deployment of any specified contract via params
    event Deploy(address);

    fallback() external payable{}//The keyword 'payable' adds functionality to send & receive ETH

    function deploy(bytes memory _code)external payable returns(address addr){
        //new <contract name>(); <--This would be the syntax to deploy any existing contract (such as 'uno' or 'dos')
        assembly{
            /*create(v, p, n)
            v=amount of ETH to send
            p=pointer in memory to start of code
            n=size of code*/
            addr := create(callvalue(), add(_code, 0x20), mload(_code))//Sets the value of a variable & returns it; just condensed to a single line
        }
        require(addr != address(0), "Deployment failure");
        emit Deploy(addr);
    }
    function execute(address _target, bytes memory _data)external payable{
        (bool success,) = _target.call{value:msg.value}(_data);
        require(success, "failed");
    }
}
contract helper{
    function getByteCode1()external pure returns(bytes memory){
        bytes memory bytecode = type(uno).creationCode;//ASSUMPTION: You can return the byte code for a contract (w/o any params) by simply getting the '.creationCode' of the contract 'type'. E.g., <bytes memory var1 = type(<contract name>).creationCode;>
        return bytecode;
    }
    function getByteCode2(uint _x, uint _y) external pure returns(bytes memory){
        bytes memory bytecode = type(dos).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_x, _y));//ASSUMPTION: In order to access params within a contract (particularly for a constructor or something) you will need the '.encodePacked' abi thing & you'll also need to pass the params via 'abi.encode()'
    }
    function getCalldata(address _owner) external pure returns(bytes memory){
        return abi.encodeWithSignature("setOwner(address)", _owner);//See the last line of the "shpiel"
    }
}
/*I'll clear this part up later, until then, it's just gonna be a shpiel of random thought and considerations for the above code

So, you can deploy various contracts, but not at the same time
You can also get different types of info by reading the data of contracts(?)
I'm not too sure about this one, but im guessing that you can also access various stuff inside of contracts w/o explicitly running them because all contracts on the blockchain are "open-source"(?)
The 'abi' prefix thing perhaps references the metadata or something (probably 'bytecode', since that's being thrown away everywhere) of a contract/function(?)
(in the Remix compiler) Payable functions appear red on the deployment screen
The 'bytes' data type must be copied onto memory in order to be used fully within a function (similarly to strings)?
(To an extent) [Consider that the bytecode is in hex] If you can interpret the bytecode of a smart contract, you can even go as far as figuring out the params entered and maybe even more details of the contract, all w/o explicitly looking at the contract's .sol or plaintext
(Pertaining to the calldata) For the data in this .sol file, the calldata appears to be: '0x13af40350' (maybe the last 0 is not a part of it; maybe this is the 'signature'?). The rest of what is left of the displayed calldata (after the many zeroes) is the address thart is passed as the param*/
