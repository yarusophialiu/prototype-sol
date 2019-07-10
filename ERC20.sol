pragma solidity ^0.4.23;

contract ERC20Interface {
    function totalSupply() public view returns (uint);
    // function balanceOf(address tokenOwner) public view returns (uint balance);
    function transfer(address _to, uint _value) public returns (bool success);
    
    // function allowance(address _owner, address _spender) public view returns (uint256 remaining);
    // function approve(address _spender, uint _value) public returns (bool success);
    // function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract Cryptos is ERC20Interface {
    string public name = "Cryptos";
    string public symbol = "CRPT";
    uint public decimals = 0;
    
    uint public supply;
    bool public propertyOwner;
    address public founder;
    // owner address and its supply
    mapping(address => uint) public balances;
    
    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    constructor(uint _supply, bool _isOwner, address _founder) public {
        supply = _supply;
        founder = _founder;
        propertyOwner = _isOwner;
        balances[founder] = supply;
    }
    
    function totalSupply() public view returns (uint) {
        return supply;
    }
    
    // supply of the property
    function balanceOf(address tokenOwner) public view returns (uint balance) {
     return balances[tokenOwner];
    }
    
    // transfer Cryptos to the address provided
    function transfer(address _to, uint _value) public returns (bool success) {
     require(balances[msg.sender] >= _value && _value > 0);
     balances[_to] += _value;
     balances[msg.sender] -= _value;
     emit Transfer(msg.sender, _to, _value);
     return true;
    }
    
}


















