pragma solidity ^0.4.23;
import './ERC20.sol';

// repository of cryptos
// note that owner of the DeedRepo is the propertyRepo contract that created the DeedRepo
contract DeedRepo is Cryptos {
    uint public supply;
    bool public isOwner;
     // owner address and its supply
    Cryptos public crypto;
    
    constructor (uint _supply, bool _isOwner) Cryptos(supply, isOwner, founder) public{
        supply = _supply;
        isOwner = _isOwner;
        founder = msg.sender;
    }
    
    // create a crypto of the DeedRepo
    function registerDeed() public {
        crypto = new Cryptos(supply, true, msg.sender);
    }
    
    // get crypto address
    function getCrypto() public view returns (Cryptos){
        return crypto;
    }
}