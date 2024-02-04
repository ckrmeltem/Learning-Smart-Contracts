// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ProposalContract {
    address private owner;
    uint256 private counter;
    address[] private voted_addresses;

    modifier active() {
        require(proposal_history[counter].is_active == true, "The proposal is not active");
        _;
    }

    modifier notVoted() {
        require(hasNotVoted(msg.sender), "You have already voted");
        _;
    }

    struct Proposal {
        string title;
        string description;
        uint256 approve;
        uint256 reject;
        uint256 pass;
        uint256 total_vote_to_end;
        bool current_state;
        bool is_active;
    }

    mapping(uint256 => Proposal) proposal_history;

    constructor() {
        owner = msg.sender;
        voted_addresses.push(msg.sender);
    }

    function hasNotVoted(address voter) internal view returns (bool) {
        for (uint256 i = 0; i < voted_addresses.length; i++) {
            if (voted_addresses[i] == voter) {
                return false; // Voter has already voted
            }
        }
        return true; // Voter has not voted yet
    }

    function create(string calldata _title, string calldata _description, uint256 _total_vote_to_end) external onlyOwner {
        counter += 1;
        proposal_history[counter] = Proposal(_title, _description, 0, 0, 0, _total_vote_to_end, false, true);
    }

    function vote(uint8 choice) external active notVoted {
        Proposal storage proposal = proposal_history[counter];
        uint256 total_vote = proposal.approve + proposal.reject + proposal.pass;

        if (choice == 1) {
            proposal.approve += 1;
            proposal.current_state = calculateState();
        } else if (choice == 2) {
            proposal.reject += 1;
            proposal.current_state = calculateState();
        } else if (choice == 0) {
            proposal.pass += 1;
            proposal.current_state = calculateState();
        }

        if ((proposal.total_vote_to_end - total_vote == 1) && (choice == 1 || choice == 2 || choice == 0)) {
            proposal.is_active = false;
        }

        voted_addresses.push(msg.sender); // Record the address that voted
    }

    function setOwner(address new_owner) external onlyOwner {
        owner = new_owner;
    }

    function calculateState() internal view returns (bool) {
        // Your logic for calculating the state of the proposal based on votes
        // Example: if the majority is for approval, return true; otherwise, return false;
    }
}
