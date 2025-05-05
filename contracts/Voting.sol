// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Voting {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    address public owner;
    bool public electionStarted;
    bool public electionEnded;
    uint public candidatesCount;
    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this");
        _;
    }

    modifier electionOngoing() {
        require(electionStarted && !electionEnded, "Election is not active");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addCandidate(string memory _name) public onlyOwner {
        require(!electionStarted, "Cannot add candidates after election has started");
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function startElection() public onlyOwner {
        require(!electionStarted, "Election already started");
        require(candidatesCount > 1, "Add at least 2 candidates");
        electionStarted = true;
    }

    function endElection() public onlyOwner {
        require(electionStarted, "Election not started");
        require(!electionEnded, "Election already ended");
        electionEnded = true;
    }

    function vote(uint _candidateId) public electionOngoing {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");

        candidates[_candidateId].voteCount++;
        hasVoted[msg.sender] = true;
    }

    function getCandidate(uint _id) public view returns (string memory, uint) {
        Candidate memory c = candidates[_id];
        return (c.name, c.voteCount);
    }

    function getWinner() public view returns (string memory winnerName, uint winnerVotes) {
        require(electionEnded, "Election not ended yet");
        uint highestVote = 0;
        uint winnerId = 0;

        for (uint i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > highestVote) {
                highestVote = candidates[i].voteCount;
                winnerId = i;
            }
        }

        Candidate memory winner = candidates[winnerId];
        return (winner.name, winner.voteCount);
    }
}
