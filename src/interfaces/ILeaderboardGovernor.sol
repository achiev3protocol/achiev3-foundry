/*
             _     _           ____  
            | |   (_)         |___ \ 
   __ _  ___| |__  _  _____   ____) |
  / _` |/ __| '_ \| |/ _ \ \ / /__ < 
 | (_| | (__| | | | |  __/\ V /___) |
  \__,_|\___|_| |_|_|\___| \_/|____/ 

  decentralized, permissionless achievements protocol
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import '../structs/LeaderboardScore.sol';

interface ILeaderboardGovernor {
    function recordScore(uint256 score, address player) external;
    function setCanRecordScores(address user, bool canRecord) external;
    function setCollectionIconCid(string memory cid) external;
    function getScoreCount() external view returns (uint256);
    function getLeaderboardScoreByTokenId(uint256 tokenId) external view returns (LeaderboardScore memory);
}

