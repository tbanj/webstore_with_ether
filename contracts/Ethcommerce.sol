// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;


contract Ethcommerce {
    address public owner;
    constructor() {
        owner = msg.sender;
    }

    struct Item {
        uint256 id;
        string name;
        string category;
        string image;
        uint256 cost;
        uint256 rating;
        uint256 stock;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    mapping(uint256 => Item) public items;
    event List(string name, uint256 cost, uint256 quantity);

    function list(
        uint256 _id,
        string memory _name,
        string memory _category,
        string memory _image,
        uint256 _cost,
        uint256 _rating,
        uint256 _stock
    ) public onlyOwner {
        // Create Item
        Item memory item = Item(
            _id,
            _name,
            _category,
            _image,
            _cost,
            _rating,
            _stock
        );


        // Add Item to mapping
        items[_id] = item;


        // Emit event
        emit List(_name, _cost, _stock);
    }

    
}