//SPDX-License-Identifier: q
pragma solidity ^0.8.0;

contract selfDelete{
    constructor()payable{}//This constructor only exists so that this contract can receive ETH (to showcase the functionality of 'selfdestruct')
    function kill()external{
        selfdestruct(payable(msg.sender));//'selfdestruct()' deletes this contract & sends all ETH in this contract to the specified address, whether they accept ETH or not. They're going to receive the ETH by force 
    }//the address specified in 'selfdestruct()' must be made 'payable'
}

contract biggyPank{
    address public owner = msg.sender;
    event Deposit(uint amount);
    event Withdraw(uint amount);

    modifier ownerCheck(){
        require(msg.sender == owner, "not owner, can't proceed");
        _;
    }

    receive()external payable{
        emit Deposit(msg.value);
    }
    function withdraw()external ownerCheck{
        emit Withdraw(address(this).balance);
        selfdestruct(payable(owner));
    }
}