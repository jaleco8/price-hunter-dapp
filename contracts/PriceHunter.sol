// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

contract test {
    
    //Variables that store the id
    uint public createIdMarket;
    uint public createIdProduct;

    struct Product { 
        uint id;
        string name;
        uint quantity;
        uint price;
        uint total;
        uint key;       //fiscal notes key 
        uint market_id; 
    }

    struct Market {
        uint id;
        string name; 
        uint cnpj;
    }
      
    mapping(uint => Product) public products;
    mapping(uint => Market) public markets;

    constructor() public {
        //Initial variables that store the id
        createIdMarket = 0;
        createIdProduct = 0;
        addMarket("Redmix", 1111 );
        addMarket("Hiperideal", 2222);
        addProduct("arroz",  1, 7, 7, 1001, 1111);
        addProduct("queso",  1, 15, 15, 1001, 1111);
        addProduct("queso", 1, 16, 16, 2002, 2222);
        addProduct("arroz", 1, 8, 8, 2002, 2222);
    }

    //function to add products 
    function addProduct(string memory _name, uint _quantity, uint _price, uint _total, uint _key, uint _cnpj) public {
        products[createIdProduct] = Product(createIdProduct, _name, _quantity, _price, _total, _key, getIdMarket(_cnpj));
        createIdProduct++;
    }

    //function to add markets
    function addMarket(string memory _name, uint _cnpj) public {
        require(isUnique(_cnpj) == true);
        markets[createIdMarket] = Market(createIdMarket, _name, _cnpj);
        createIdMarket++;
    }

    //function to get one market, param id market 
    function getMarket(uint _id) public view returns (uint[] memory, string[] memory,uint[] memory){
        require(_id <= createIdMarket);
        uint[] memory id = new uint[](1);
        string[] memory name = new string[](1);
        uint[] memory cnpj = new uint[](1);

        Market memory market = markets[_id];
        id[0] = market.id;
        name[0] = market.name;
        cnpj[0] = market.cnpj;

        return (id, name,cnpj);
    }

    //function that checks if the entire market is not registered, param cnpj
    function isUnique(uint _cnpj) public view returns (bool uniqueMarket){
        uniqueMarket =  true;
        uint[] memory cnpj = new uint[](createIdMarket);

        for(uint i; i < createIdMarket; i++){
            Market memory market = markets[i];
            cnpj[i] = market.cnpj;
            if(cnpj[i] == _cnpj){
                uniqueMarket = false;
            }
        }
    }

    //function that returns the id of the market
    function getIdMarket(uint _cnpj) public view returns (uint idMarket){
        idMarket =  0;
        uint[] memory cnpj = new uint[](createIdMarket);
        uint[] memory id = new uint[](createIdMarket);
        
        for(uint i; i < createIdMarket; i++){
            Market memory market = markets[i];
            cnpj[i] = market.cnpj;
            id[i] = market.id;
            if(cnpj[i] == _cnpj){
                idMarket = id[i];
            }
        }
    }
  
    //function to get all market
    function getAllMarkets() public view returns (Market[] memory allMarkets){
        allMarkets = new Market[](createIdMarket);
        
        for (uint i = 0; i < createIdMarket; i++) {
            Market memory market = markets[i];
            allMarkets[i] = market;
        }
    }

    //function to get all product
    function getAllProduct() public view returns (Product[] memory allProducts){
        allProducts = new Product[](createIdProduct);
        
        for (uint i = 0; i < createIdProduct; i++) {
            Product memory product = products[i];
            allProducts[i] = product;
        }
    }
}