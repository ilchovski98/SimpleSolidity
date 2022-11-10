// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    function create(string calldata _text) external {
        todos.push(Todo({text: _text, completed: false}));
    }

    function updateText(uint _index, string calldata _text) external {
        // One time update this is good
        todos[_index].text = _text;

        //Multiple updates this is good
        // Todo storage todo = todos[_index];
        // todo.text = _text;
        // todo.text = _text;
        // todo.text = _text;
    }

    function get(uint _index) view external returns (string memory, bool) {
        Todo memory todo = todos[_index];
        return (todo.text, todo.completed);
    }

    function toggleCompleted(uint _index) external {
        todos[_index].completed = !todos[_index].completed;
    }
}
