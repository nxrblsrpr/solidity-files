//SPDX-License-Identifier: q
pragma solidity ^0.8.0;

contract A{
  string public name;
  constructor(string memory _name){
    name = _name;
  }
}
contract B{
  string public text;
  constructor(string memory _text){
    text = _text;
  }
}
//2 ways to call parent constructors
contract C is A("nombre"), B("txt"){}//If you already know what the exact params are, you can just put them in the contract initialization
contract D is A, B{
  constructor(string memory _name, string memory _text) A(_name) B(_text){}//If you don't know what the exact params are, then you can allow for them to be passed into the constructor
}
contract E is A("nombre"), B{//You can also use a combination of both
  constructor(string memory _text) B(_text){}
}
/*Order of inheritance:
If all the inherited contracts are the least derived (<--Change that to the appropriate word), 
then the order of inheritance is as declared in the contract initialization
E.g., 'contract F is B, A' will run through entities in this order: B, A, F
In the same way, 'contract F is A, B' will run through entities in this order: A, B, F*/

//Inheriting functions
//!!!When you're calling a function, make sure you're doing it from within a function (save yourself the headache)!!!

contract One{
  event Log(string message);
  function uno() public virtual{
    emit Log("msg 1");
  }
  function dos() public virtual{
    emit Log("msg 2");
  }
}
contract Two is One{
  function uno() public virtual override{
    emit Log("msg 11");
    One.uno();//By prepending the contract name to the function that we're referencing, it can be called via the appropriate parent contract
  }
  function dos() public virtual override{
    emit Log("msg 22");
    super.dos();//'super' is a keyword (remember 'superclass' in java?) that makes a reference to a function of a parent contract (the function name is appended after 'super')
  }
}
//There is no difference between making a reference to the parent contract and using the 'super' keyword
contract Three is One{
  function uno() public virtual override{
    emit Log("msg 111");
    super.uno();
  }
  function dos() public virtual override{
    emit Log("msg 222");
    One.dos();
  }
}
contract Four is Two, Three{
  function uno() public override (Two, Three){//When inheriting functions form multiple contracts, be certain to include the [parent contracts in the function declaration
    //sample code
    Two.uno();//In the context of multiple parent functions being referenced, ONLY the prepended contract's function will be called
  }
  function dos() public override (Two, Three){
    //sample code
    super.dos();//Using super in the context of multiple parent functions being referenced, it will call the respective function from all parents
  }
}
