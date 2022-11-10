// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract SimpleStructs {
    struct Product {
        string name;
        uint id;
        uint quantity;
    }

    Product public product;
    Product[] public products;
    mapping(address => Product[]) public productsByOwner;

    function examples() external {
        Product memory dogToy = Product("Dog toy", 111, 100);
        Product memory catToy = Product({name: "Cat toy", id: 112, quantity: 100});
        Product memory fishToy;
        fishToy.name = "Fish toy";
        fishToy.id = 113;
        fishToy.quantity = 20;

        products.push(dogToy);
        products.push(catToy);
        products.push(fishToy);
        products.push(Product("ball", 114, 33));

        Product storage _product = products[0]

        delete products[1];
    }
}
