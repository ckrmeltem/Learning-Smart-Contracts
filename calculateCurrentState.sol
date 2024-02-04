function calculateCurrentState() private view returns(bool) {
    Proposal storage proposal = proposal_history[counter];

    uint256 approve = proposal.approve;
    uint256 reject = proposal.reject;
    uint256 pass = proposal.pass;
        
    if (proposal.pass %2 == 1) {
        pass += 1;
    }

    pass = pass / 2;

    if (approve > reject + pass) {
        return true;
    } else {
        return false;
    }
}

/*
function calculateCurrentState() private view returns (bool) {
    Proposal storage proposal = proposal_history[counter];

    // Check if the number of approve votes is greater than or equal to reject votes
    if (proposal.approve >= proposal.reject) {
        return true;
    } else {
        return false;
    }
}
*/
