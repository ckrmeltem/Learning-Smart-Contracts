// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


contract ProposalContract {
    address private owner; 
    uint256 private counter; // This line is added
    struct Proposal {
        string description; // Description of the proposal
        uint256 approve; // Number of approve votes
        uint256 reject; // Number of reject votes
        uint256 pass; // Number of pass votes
        uint256 total_vote_to_end; // When the total votes in the proposal reaches this limit, proposal ends
        bool current_state; // This shows the current state of the proposal, meaning whether if passes of fails
        bool is_active; // This shows if others can vote to our contract
    }


    mapping(uint256 => Proposal) proposal_history; // Recordings of previous proposals

   // Constructor to set the owner of the contract
    constructor() {
        owner = msg.sender;
    }
// Modifier to check if the caller is the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

function createProposal(string calldata_title, string calldata_description, uint256_total_vote_to_end) external {
counter +=1;
proposal_history[counter] = Proposal(_title, _description 0,0,0, _total_vote_end, false, true
}
}
