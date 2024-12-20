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

    function buy(uint256 _id) public payable {
        // Fetch item
        Item memory item = items[_id];


        // Require enough ether to buy item
        require(msg.value >= item.cost);


        // Require item is in stock
        require(item.stock > 0);


        // Create order
        Order memory order = Order(block.timestamp, item);


        // Add order for user
        orderCount[msg.sender]++; // <-- Order ID
        orders[msg.sender][orderCount[msg.sender]] = order;


        // Subtract stock
        items[_id].stock = item.stock - 1;


        // Emit event
        emit Buy(msg.sender, orderCount[msg.sender], item.id);
    }
    
    mapping(address => mapping(uint256 => Order)) public orders;
 mapping(address => uint256) public orderCount;

 struct Order {
        uint256 time;
        Item item;
  }

  event Buy(address buyer, uint256 orderId, uint256 itemId);

 function withdraw() public onlyOwner {
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success);
    }

}