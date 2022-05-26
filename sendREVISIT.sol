//SPDX-License-Identifier: q
pragma solidity ^0.8.8;
//There are some gaps in your understanding of this concept, this is def something you're going to want to revisit 
/*3 ways to send ETH
'transfer()': Function that is available to a payable address. Sends 2300 gas; if the send fails, then an error [revert()] is thrown (the whole function fails). If used upon a contract, the contract only has 2300 gas to execute code
'send()': Sends 2300 gas; if the send fails, a bool is returned, indicating if the send was successful
'call()': Forwards all gas; returns bool (indicating if the call was successful), also returns data
*/

contract sendETH{
    constructor() payable{/*ETH will be sent to this contract when it's deployed*/}
    //fallback() external payable{}//This can be used for the same purposes as the receive(), but it is deprecated in this contract to discourage attempts to call non-existent functions that would trigger a fallback()
    receive() external payable{}//This contract can receive ETH, but if an attempt is made to call a function that doesn't exist, no fallback() is present, so the function call will just fail

    function sendViaTransfer(address payable _to) external payable{
        _to.transfer(50);//Enter the amount of ETH that you want to transfer as a param
    }
    function sendViaSend(address payable _to) external payable{
        bool sent = _to.send(50);
        require(sent, "send failed");//Lots of contracts on mainnet will never use 'send()'
    }
    function sendViaCall(address payable _to) external payable{
        (bool successful, /*bytes memory datum <--You can also get data, but not necessary rn*/) = _to.call{value:50}("");
        require(successful, "call failed");
    }
}
contract receiveETH{
    event Log(uint amount, uint gas);
    receive()external payable{
        emit Log(msg.value, gasleft());
    }
}
//'transfer()' forwards 2300 gas, but (in the future) if opcodes lower gas costs, 2300 gas may be sufficient for a re-entrancy attack
//'call' is recommended (by Consensys) to ensure that no function is vulnerable to a re-entrancy attack (well maybe not all, but your contract would be a bit more hardened)
//Basically, 'call' is future proof & 'transfer()' is not (Future changes that implement gas efficiency will allow for the possibility of the transfer function being exploitable to enable re-entrancy attacks)

contract wallet{//Anyone can send ETH to this contract but, only the owner will be able to send ETH out of the contract
    address public owner;
    constructor(){
        owner = payable(msg.sender);
    }
    receive() external payable{}//Very simple function that will enable this contract to receive ETH

    function withdraw(uint _amount) external{
        require(msg.sender == owner, "you're not the owner bro");
        //owner.transfer(amount); <--This is valid code, except for the fact that the same thing can be accomplished in a more gas efficient manner (by using 'msg.sender' instead of a state variable ['owner'])
        
        //payable(msg.sender).transfer(_amount); <--This is also valid code, and heeds the above statement however, instead of using 'transfer()', 'call()' can be used (More secure method of coding)
        
        (bool sent, ) = msg.sender.call{value:_amount}("");
        require(sent, "failed to send ETH");//This line and the above accomplish the same thing as the two former lines but, in a more gas efficient & secure way
    }
    function getBalance()external view returns(uint){
        return address(this).balance;
    }
}