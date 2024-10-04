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

import 'erc721a-upgradeable/contracts/ERC721AUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import '../structs/LeaderboardScore.sol';

error NotAuthorizedToAwardScores();
error ScoreWorseThanPrevious();

/**
 * @title AchievementSetGovernor
 * @dev Contract for managing a leaderboard
 */
contract LeaderboardGovernor is ERC721AUpgradeable, OwnableUpgradeable {
    /**
     * @dev Mapping of addresses that are allowed to award achievements from this set.
     */
    mapping(address => bool) public canUpdateScores;

    /**
     * @dev Mapping of addresses to the token ID of their high score NFT
     */
    mapping(address => uint256) public tokenIds;

    /**
     * @dev Mapping of addresses to their scores
     */
    mapping(uint256 => address) public players;

    /**
     * @dev Mapping of token IDs to their scores
     */
    mapping(uint256 => uint256) public scores;

    /**
     * @dev Whether the leaderboard is descending (true) or ascending (false)
     */
    bool public isDescending = true;

    /**
     * @dev Total number of scores in this leaderboard
     */
    uint256 scoreCount = 0;

    /**
     * @dev Smart contract that tracks the canonical addresses of other contracts in the protocol.
     */
    address contractRegistry;

    /**
     * @dev IPFS CID for the icon of the leaderboard
     */
    string public leaderboardIconCid;

    /**
     * @dev Constructor for the AchievementSetGovernor contract.
     */
    constructor(string memory collectionName, string memory collectionSymbol, address _contractRegistry, address owner) initializerERC721A initializer {
        contractRegistry = _contractRegistry;

        __ERC721A_init(collectionName, collectionSymbol);
        __Ownable_init(owner);
    }

    function setCollectionIconCid(string memory cid) public onlyOwner {
        leaderboardIconCid = cid;
    }

    /**
     * @dev Unlock a given achievement to a given address. Must be authorized to award achievements.
     */
    function recordScore(uint256 score, address player) external {
        // Ensure the calling address is allowed to award achievements
        if (!canUpdateScores[msg.sender]) {
            revert NotAuthorizedToAwardScores();
        }

        // Ensure they have a high score NFT
        if(tokenIds[player] == 0) {
            _mint(player, 1);

            tokenIds[player] = _totalMinted();
            players[tokenIds[player]] = player;

            scoreCount++;
        }

        // Ensure the score is better than the previous score
        if(scores[tokenIds[player]] > score && isDescending) {
            revert ScoreWorseThanPrevious();
        } else if(scores[tokenIds[player]] < score && !isDescending) {
            revert ScoreWorseThanPrevious();
        }

        // Update the stored score
        scores[tokenIds[player]] = score;
    }

    /**
     * @dev Sets whether a given address is allowed to update scores on the leaderboard
     */
    function setCanUpdateScores(address account, bool canAward) external onlyOwner {
        canUpdateScores[account] = canAward;
    }

    /**
     * @dev Get the total number of scores in this leaderboard.
     */
    function getScoreCount() public view returns (uint256) {
        return scoreCount;
    }

    function getLeaderboardScoreByTokenId(uint256 tokenId) public view returns (LeaderboardScore memory) {
        address player = players[tokenId];

        return LeaderboardScore(player, scores[tokenIds[player]]);
    }

    /**
     * @dev Metadata for leaderboard score NFTs.
     */
    /*function tokenURI(uint256 tokenId) public view override returns (string memory) {
        LeaderboardScore memory score = getLeaderboardScoreByTokenId(address(tokenId));

        return string(abi.encodePacked('data:application/json;base64,', abi.encodePacked('{"name":"', ach.name, '","description":"', ach.description , '","image":"ipfs://', imageCids[0], '/"}')));
    }*/
}