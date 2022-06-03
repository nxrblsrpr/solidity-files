//SPDX-License-Identifier: q
pragma solidity ^0.8.0;
//'keccak256' is a hashing algo that can be used to sign a signature, come up w/ a unique ID, or create a contract that is protected from front-running (commit reveal scheme)
contract keccakaccek{
    function hash(string memory text, uint num, address addr)external pure returns(bytes32){
        return keccak256(abi.encodePacked(text, num, addr));//this will convert the input data into a keccak256 hash (which is of type bytes32)
    }
    function hashh(string memory textt, string memory texttt) external pure returns(bytes memory){//when returning 'bytes', you must load it onto 'memory'
        return abi.encode(textt, texttt);
    }
    function hashhh(string memory textt, string memory texttt) external pure returns(bytes memory){
        return abi.encodePacked(textt, texttt);
    }
}

/*Passing multiple dynamic data types (e.g., strings) may result in a hash collision depending (same hash output for different inputs) on the input
To avoid hash collisions, you can use 'abi.encode()' (instead of 'abi.encodePacked') or make it so that the inputs or your dynamic data types aren't next to each other (e.g., instead of <string, string, uint>, use <string, uint, string>) 
'abi.encode()' encodes data into bytes (a.k.a. bytecode)
'abi.encodePacked()' encodes data into bytes (a.k.a. bytecode) and also compresses the encoded data (output will be smaller)
You should prioritize using fixed length types for functions that will be called externally (conventional practice)
'bytes' is dynamic length; 'bytes32' is fixed length (32 in length)*/

/*Steps to verify a signature
-Have a message to sign
-Hash the message --> hash(message)
-Sign the hash of the message --> sign(hash(message), private key) [This is done offchain, usually involving a wallet]
-{Lastly} Verify the signature inside of the smart contract w/ 'ecrecover' --> ecrecover(hash(message), signature) == signer; check if the signer returned is the same as the original/true signer of the message*/

contract verifySig{
    function verify(address _signer, string memory _message, bytes memory _sig)external pure returns(bool){
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
        return recover(ethSignedMessageHash, _sig) == _signer;
    }
    
    function getMessageHash(string memory _message)public pure returns(bytes32){
        return keccak256(abi.encodePacked(_message));//returns a keccak256 hash
    }
    function getEthSignedMessageHash(bytes32 _messageHash)public pure returns(bytes32){
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message: \n32", _messageHash));//returns an ETH signed keccak256 hash
    }
    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig) public pure returns(address){//'_sig' is a unique form of data that comes from a wallet's "promise" (special personal signature); returns a pretty lengthy result
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);//'r' & 's' are cryptographic params used for digital signatures; 'v' is unique to Ethereum; 'uint8' is a single byte
        return ecrecover(_ethSignedMessageHash, v, r, s);//'ecrecover()' returns the address of the signer, given the signed message in addition to the other cryptographic params
    }//This will return a 
    function _split(bytes memory _sig)internal pure returns(bytes32 r, bytes32 s, uint8 v){//splits up the 
        require(_sig.length == /*32+32+1*/65, "invalid signature length");
        //'mload()' loads data based on its memory address
        assembly{//this will split up the '_sig' into 'r','s', & 'v'
            r := mload(add(_sig, 32))//val of 'r' is set to the first 32 bytes (consider how slicing works in python)
            s := mload(add(_sig, 64))//val of 's' is set to the second 32 bytes
            v := byte(0, mload(add(_sig, 96)))//val of 'v' is set to the first char of the third 32 bytes (hence <byte(0, ...>)
        }//Keep in mind that the ':=' will auto assign & return the variable
    }
}