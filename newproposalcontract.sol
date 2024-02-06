// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


contract ProposalContract {
    struct Proposal {
        string title;
        string description;
        uint256 voteCount;
        bool isActive;
    }

    Proposal[] public proposals;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addProposal(string memory _title, string memory _description) public onlyOwner {
        proposals.push(Proposal(_title, _description, 0, true));
    }

    function getProposalCount() public view returns (uint256) {
        return proposals.length;
    }

    function vote(uint256 proposalIndex) public {
        require(proposalIndex < proposals.length, "Invalid proposal index");
        require(proposals[proposalIndex].isActive, "Proposal is not active");

        proposals[proposalIndex].voteCount++;
    }

    function calculateCurrentState() public view returns (string memory) {
        uint256 totalVotes = 0;
        for (uint256 i = 0; i < proposals.length; i++) {
            totalVotes += proposals[i].voteCount;
        }

        return totalVotes > 10 ? "Over 10 votes" : "Not over 10 votes";
    }
}
