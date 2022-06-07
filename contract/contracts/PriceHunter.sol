// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

contract test {
    uint public createId;

    struct Product { 
        string name;
        uint price;
        uint key;
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
        createId = 0;
        addMaker(createId, "Redmix", 1000);
    }

    function addProduct(uint _id) public {
      //product[] = Product('papa', 5, 10001, _id);
    }

    function addMaker(uint _id, string memory _name, uint _cnpj) public {
        markets[createId] = Market(_id, _name, _cnpj);
        createId++;
    }

    function getMarket(uint _id) public view returns (uint[] memory, string[] memory,uint[] memory){
        require(_id <= createId);

        uint[] memory id = new uint[](createId);
        string[] memory name = new string[](createId);
        uint[] memory cnpj = new uint[](createId);

        Market storage market = markets[_id];
        id[_id] = market.id;
        name[_id] = market.name;
        cnpj[_id] = market.cnpj;        

        return (id, name,cnpj);
    }

    function getAllMarkets() public view returns (Market[] memory){
        Market[] memory id = new Market[](createId);
        
        for (uint i = 0; i < createId; i++) {
            Market storage market = markets[i];
            id[i] = market;
        }
        return id;
    }
}