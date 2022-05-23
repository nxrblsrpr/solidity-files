//SPDX-License-Identifier: q
pragma solidity ^0.8.0;

contract todoList{
    struct Todo{
        string text;
        bool completed;
    }
    Todo[] public todos;
    function create(string calldata _text)external{
        todos.push(Todo({text:_text, completed:false}));
    }
    function update(uint _index, string calldata _text)external{
        todos[_index].text = _text;
    }
    function get(uint _index) external view returns (string memory, bool){
        Todo storage todo = todos[_index];//You can use 'memory' instead, but 'storage' uses less gas
        return(todo.text, todo.completed);
    }
    function toggleCompleted(uint _index)external{
        todos[_index].completed = !todos[_index].completed;//Sets the status of the queried index to the opposite of whatever its current status. Pretty neat one-liner
    }
}