// SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.22;

import "./candidate.sol"; 

contract votePanel
{
    enum candidateCode{NITIN,ROHIT,MAYANK,MOHIT,NOTA}

    mapping (uint => Candidate) candidateList;

    Candidate candidate;
    Candidate public winner;
    address blockAdmin;
    address[] voterList;

uint totalCandidate;
    constructor (){
        blockAdmin = msg.sender;

//candidate initialization
candidateList[uint(candidateCode.NITIN)] = Candidate("NITIN", "Red party", 0);
candidateList[uint(candidateCode.ROHIT)] = Candidate("ROHIT", "Yellow party", 0);
candidateList[uint(candidateCode.MAYANK)] = Candidate("MAYANK", "Green party", 0);
candidateList[uint(candidateCode.MOHIT)] = Candidate("MOHIT", "Blue party", 0);
candidateList[uint(candidateCode.NOTA)] = Candidate("NOTA", "white party", 0);
 totalCandidate = uint(type(candidateCode).max) +1;

    }
    modifier checkBlockAdmin(){
        require(blockAdmin == msg.sender, "Not valid User");
        _;
    }
    modifier verifyVoterCasing(){
        address voterAddress;
        uint totalVoters = voterList.length;
        bool token = false;
         uint counter=0;
        while(counter<totalVoters){
            voterAddress = voterList[counter];
           if (voterAddress == msg.sender){
            token = true;
            break;
           }
            counter++;
        }
        require(token == false, "You have already elected your candidate, Thank You!");
        _;
       
    }

function viewBlockAdmin() view public checkBlockAdmin() returns(address){
    return blockAdmin;
}
function Nitin_Red_Party() public verifyVoterCasing() {
    //verify voter
    voterList.push(msg.sender);
    candidate = candidateList[uint(candidateCode.NITIN)];
    //Vote Increment
candidate.voteCount++;
candidateList[uint(candidateCode.NITIN)] = candidate;
}

function Rohit_Yellow_Party() public verifyVoterCasing() {
      //verify voter
    voterList.push(msg.sender);
    candidate = candidateList[uint(candidateCode.ROHIT)];
    //Vote Increment
candidate.voteCount++;

candidateList[uint(candidateCode.ROHIT)] = candidate;
}

function Mayank_Green_Party() public verifyVoterCasing() {
      //verify voter
    voterList.push(msg.sender);
    candidate = candidateList[uint(candidateCode.MAYANK)];
    //Vote Increment
candidate.voteCount++;
candidateList[uint(candidateCode.MAYANK)] = candidate;
}

function Mohit_Yellow_Party() public verifyVoterCasing() {
      //verify voter
    voterList.push(msg.sender);
    candidate = candidateList[uint(candidateCode.MOHIT)];
    //Vote Increment
candidate.voteCount++;
candidateList[uint(candidateCode.MOHIT)] = candidate;
}
function Nota_White_Party() public verifyVoterCasing() {
      //verify voter
    voterList.push(msg.sender);
    candidate = candidateList[uint(candidateCode.NOTA)];
    //Vote Increment
candidate.voteCount++;
candidateList[uint(candidateCode.NOTA)] = candidate;
}

function voteCountAndWinner() public checkBlockAdmin() {
  uint maxCount = 0;
  
  uint counter = 0;
while(counter < totalCandidate){
    candidate = candidateList[counter];
    if (maxCount < candidate.voteCount){
        winner = candidate;
        maxCount = candidate.voteCount;
    }
counter++;
}
} 
function totalVotesCasted() view public checkBlockAdmin() returns(uint){
    uint totalVoters = voterList.length;
    return totalVoters;
}

}