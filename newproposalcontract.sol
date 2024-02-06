// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract NewProposalContract {
    uint256 private _storedData;
    bool private _isActive;
    address private _owner;
    mapping(address => bool) private _hasVoted;

    event ValueChanged(uint256 indexed oldValue, uint256 indexed newValue);
    event Voted(address indexed voter);
    event OwnerChanged(address indexed oldOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == _owner, "Only owner can call this function");
        _;
    }

    modifier active() {
        require(_isActive, "Contract is not active");
        _;
    }

    modifier newVoter() {
        require(!_hasVoted[msg.sender], "You have already voted");
        _;
    }

    constructor() {
        _owner = msg.sender;
        _isActive = true; // You can set this to false initially if you want the contract to start inactive
    }

    function get() public view returns (uint256) {
        return _storedData;
    }

    function set(uint256 newValue) public onlyOwner active {
        uint256 oldValue = _storedData;
        _storedData = newValue;
        emit ValueChanged(oldValue, newValue);
    }

    function toggleActivation() public onlyOwner {
        _isActive = !_isActive;
    }

    function vote() public active newVoter {
        _hasVoted[msg.sender] = true;
        emit Voted(msg.sender);
    }

    function setOwner(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid new owner address");
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnerChanged(oldOwner, newOwner);
    }

    function calculateCurrentState() public view returns (string memory) {
        return _storedData > 10 ? "Over 10" : "Not over 10";
    }
}
