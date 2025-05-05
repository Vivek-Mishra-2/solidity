// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // This is the latest solidity version

contract SimpleStorage {
    // Types in Solidity: boolean, uint, int, address, bytes
    // bool hasFavoriteNumber = true;
    // uint favoriteNumber = 123;
    // int favoritNumber = -123;
    // string favoriteNumberInText = 'Five';
    // address myAddress = 0x102023dfv043540;
    // bytes32 favoriteBytes = "cat";

    // This automatically gets initialized with 0 when no value is initialised
    uint256 favoriteNumber; 

    struct  People {
        uint256 favoriteNumber;
        string name;
    }
    
    mapping(string => uint256) public nameTofavoriteNumber;

    // uint256[] public favoriteNumber;
    People[] public people;

    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        // People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        // people.push(newPerson);

        people.push(People(_favoriteNumber, _name));
        nameTofavoriteNumber[_name] = _favoriteNumber;
    }
    
}
