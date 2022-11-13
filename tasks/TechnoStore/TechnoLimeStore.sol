// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
pragma abicoder v2;

import "./Ownable.sol";

contract TechnoStore is Ownable {
    struct Product {
        string name;
        uint id;
        uint quantity;
        address[] clientsThatPurchased;
        bool isAvailable;
    }
    struct ProductPreview {
        string name;
        uint id;
    }
    struct Order {
        uint product_id;
        uint block_number;
    }

    uint[] private allProductIds;
    ProductPreview[] private availableProducts;
    mapping(uint => uint) private indexOfAvailableProducts;
    mapping(uint => Product) private productDatabase;
    mapping(address => mapping(uint => Order)) public clientsProductOrderDetails;

    event Purchase(
        address indexed sender,
        uint indexed product_id
    );
    event Return(
        address indexed sender,
        uint indexed product_id
    );
    event ManualProductQuantityChange(uint indexed product_id);
    event CreateProduct(uint product_id);

    // Owner can create new products
    function createProduct(
        string calldata _name,
        uint _id,
        uint _quantity
    ) external isOwner {
        require(productDatabase[_id].id != _id, "The product is already in the store");
        productDatabase[_id].name = _name;
        productDatabase[_id].id = _id;
        productDatabase[_id].quantity = _quantity;
        allProductIds.push(_id);
        updateProductAvailability(_id);
        emit CreateProduct(_id);
    }

    // Owner can update quantity of existing products
    function updateProductQuantity(uint _id, uint _quantity) external isOwner {
        require(productDatabase[_id].id != 0, "Product doesn't exist");
        productDatabase[_id].quantity = _quantity;
        updateProductAvailability(_id);
        emit ManualProductQuantityChange(_id);
    }

    // User can buy 1 available product per type
    function buyProduct(uint _product_id) external {
        Product storage currentProduct = productDatabase[_product_id];
        require(currentProduct.quantity > 0, "Product is out of stock");
        require(
            clientsProductOrderDetails[msg.sender][_product_id].product_id == 0,
            "You can't buy more than 1pc of this product"
        );
        currentProduct.quantity -= 1;
        updateProductAvailability(_product_id);
        clientsProductOrderDetails[msg.sender][_product_id] = Order({
            product_id: _product_id,
            block_number: block.number
        });
        currentProduct.clientsThatPurchased.push(msg.sender);
        emit Purchase(msg.sender, _product_id);
    }

    // User can return purchased product within 100 blocks
    function returnProduct(uint _product_id) external {
        Order storage orderDetails = clientsProductOrderDetails[msg.sender][_product_id];
        require(orderDetails.product_id != 0, "You haven't purchased this product");
        require(
            (block.number - orderDetails.block_number) < 100,
            "The return period of 100 blocks have already passed"
        );
        productDatabase[_product_id].quantity += 1;
        updateProductAvailability(_product_id);
        delete clientsProductOrderDetails[msg.sender][_product_id];
        emit Return(msg.sender, _product_id);
    }

    // Get all available product previews (title, id)
    function getAvailableProducts() external view returns(ProductPreview[] memory) {
        return availableProducts;
    }

    // Get all product ids (for the convenience of the owner)
    function getAllProductIds() external view returns(uint[] memory) {
        return allProductIds;
    }

    // Get all user addresses that have purchased certain product
    function getClientAddressesOfProduct(uint _product_id) external view returns(address[] memory) {
        return productDatabase[_product_id].clientsThatPurchased;
    }

    // Update availability product array and product state
    function updateProductAvailability(uint _id) private {
        Product storage currentProduct = productDatabase[_id];

        if (currentProduct.quantity > 0) {
            if (!currentProduct.isAvailable) {
                indexOfAvailableProducts[_id] = availableProducts.length;
                availableProducts.push(ProductPreview(currentProduct.name, currentProduct.id));
                currentProduct.isAvailable = true;
            }
        } else {
            if (currentProduct.isAvailable) {
                removeProductFromAvailableProducts(indexOfAvailableProducts[_id]);
                currentProduct.isAvailable = false;
            }
        }
    }

    // Remove product preview from the available products array
    function removeProductFromAvailableProducts(uint _index) private {
        availableProducts[_index] = availableProducts[availableProducts.length - 1];
        availableProducts.pop();
    }
}
