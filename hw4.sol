// First part
Proposal storage proposal = proposal_history[counter];
uint256 total_vote = proposal.approve + proposal.reject + proposal.pass;

// Second part
if (choice == 1) {
    proposal.approve += 1;
    proposal.current_state = calculateCurrentState();
} else if (choice == 2) {
    proposal.reject += 1;
    proposal.current_state = calculateCurrentState();
} else if (choice == 0) {
    proposal.pass += 1;
    proposal.current_state = calculateCurrentState();
}

// Third part
if ((proposal.total_vote_to_end - total_vote == 1) && (choice == 1 || choice == 2 || choice == 0)) {
    proposal.is_active = false;

}
