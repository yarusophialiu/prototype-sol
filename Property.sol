pragma solidity ^0.4.23;
import './ERC20.sol';
import './DeedRepo.sol';

contract PropertyFactory {
    address[] public deployedProperties;
    
    function createProperty() public {
       address newProperty = new PropertyRepository(msg.sender);
       deployedProperties.push(newProperty);
    }
    
    // get all properties
    function getDeployedCampaigns() public view returns (address[]) {
        return deployedProperties;
    }
}

contract PropertyRepository {
    struct Property {
        mapping(address => bool) investApproval;
        address owner;
        address cryptos;
    }
    
    struct Investor {
        address investorAddress;
        uint amount;
    }
    
    Property[] public properties;
    address public manager;
    mapping(address => Investor) public investors;
    mapping(address => bool) public investorIndex;
    uint public investorsCount;
    address public deed;
    
    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
    
    constructor (address creator) public {
        manager = creator;
    }

    function invest() public payable {
        // if the investor already invested
        if (investorIndex[msg.sender]) {
            investors[msg.sender].amount += msg.value;
        } else {
            // the investor hasn't invested 
            investors[msg.sender].investorAddress = msg.sender;
            investors[msg.sender].amount = msg.value;
            investorsCount++;
        }
        // transfer erc20 to investor
        DeedRepo deedToken = DeedRepo(deed);
        Cryptos crypto = Cryptos(deedToken.getCrypto());
        crypto.transfer(msg.sender, msg.value);
    }
    
    function createProperty() public restricted {
        // create a DeedRepo
        // note that owner of the DeedRepo is the current propertyRepo contract
        address d = new DeedRepo(1000000, true);
        deed = d;
        DeedRepo deedToen = DeedRepo(deed);
        deedToen.registerDeed();
        
        // create Property
        Property memory newProperty = Property({
            owner: msg.sender,
            cryptos: d
        });
        properties.push(newProperty);
    }
    
    // get DeedRepo address of the property
    function getDeed() public view returns (address){
        return deed;
    }
}

















