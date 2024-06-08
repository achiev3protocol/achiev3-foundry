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
import './structs/Achievement.sol';
import './interfaces/IAchievementSetGovernor.sol';

error NotAuthorizedToAwardAchievements();
error AchievementAlreadyUnlocked();
error InsufficientPoints();

/**
 * @title AchievementSetGovernor
 * @dev Contract for managing a set of achievements and awarding them to users. New contract minted for each set.
 */
contract AchievementSetGovernor is ERC721AUpgradeable, OwnableUpgradeable, IAchievementSetGovernor {
    /**
     * @dev Mapping of addresses that are allowed to award achievements from this set.
     */
    mapping(address => bool) public canAwardAchievements;

    /**
     * @dev Names of the achievements in this set, indexed by achievementId (not tokenId).
     */
    string[] names;

    /**
     * @dev Descriptions of the achievements in this set, indexed by achievementId (not tokenId).
     */
    string[] descriptions;

    /**
     * @dev IPFS CIDs for the icons of the achievements in this set, indexed by achievementId (not tokenId).
     */
    string[] iconCids;

    /**
     * @dev IPFS CIDs for the images of the achievements in this set, indexed by achievementId (not tokenId).
     */
    string[] imageCids;

    /**
     * @dev Point values for the achievements in this set, indexed by achievementId (not tokenId).
     */
    uint16[] pointValues;

    /**
     * @dev Total points remaining that have been allocated to this set.
     */
    uint16 pointAllocationRemaining = 1000;

    /**
     * @dev Total number of achievements in this set. Separate from the number of unlocks, which is represented by totalSupply()
     */
    uint256 achievementCount = 0;

    /**
    * @dev Maps tokenIds (unlocks) to achievementIds
    */
    uint256[] achievementIds;

    /**
     * @dev Maps tokenIds (unlocks) to the address that unlocked them
     */
    address[] unlockedBy;

    /**
     * @dev Tracks the time that achievements were unlcoked
     */
    uint256[] unlockTimestamps;

    /**
     * @dev Smart contract that tracks the canonical addresses of other contracts in the protocol.
     */
    address contractRegistry;

    /**
     * @dev Mapping of addresses to the achievements they have unlocked.
     */
    mapping(address => bool[]) public isUnlocked;

    /**
     * @dev Constructor for the AchievementSetGovernor contract.
     */
    constructor(string memory collectionName, string memory collectionSymbol, address _contractRegistry, address owner) initializerERC721A initializer {
        contractRegistry = _contractRegistry;

        __ERC721A_init(collectionName, collectionSymbol);
        __Ownable_init(owner);
    }

    /**
     * @dev Unlock a given achievement to a given address. Must be authorized to award achievements.
     */
    function unlockAchievement(uint256 achievementId, address unlockTo) external {
        // Ensure the calling address is allowed to award achievements
        if (!canAwardAchievements[msg.sender]) {
            revert NotAuthorizedToAwardAchievements();
        }

        if(isUnlocked[unlockTo][achievementId]) {
            revert AchievementAlreadyUnlocked();
        }

        // Mint the recipient their achievement NFT
        _mint(unlockTo, 1);

        // Store the achievement ID that was unlocked
        achievementIds.push(achievementId);

        // Store the address that unlocked the achievement
        unlockedBy.push(unlockTo);

        // Store the timestamp of the unlock
        unlockTimestamps.push(block.timestamp);

        // Mark this address as having unlocked this achievement
        isUnlocked[unlockTo][achievementId] = true;
    }

    /**
     * @dev Sets whether a given address is allowed to award achievements from this set.
     */
    function setCanAwardAchievements(address account, bool canAward) external onlyOwner {
        canAwardAchievements[account] = canAward;
    }

    /**
     * @dev Add a new achievement to this set.
     */
    function addAchievement(string memory name, string memory description, string memory iconCid, string memory imageCid) public onlyOwner {
        names.push(name);
        descriptions.push(description);
        iconCids.push(iconCid);
        imageCids.push(imageCid);

        // Need to track # of achievements separately from # of unlocks
        ++achievementCount;
    }

    /**
     * @dev Allocate points to a given achievement achievement.
     */
    function allocatePoints(uint256 achievementId, uint16 points) public onlyOwner {
        if(points > pointAllocationRemaining) {
            revert InsufficientPoints();
        }

        pointAllocationRemaining -= points;

        if(!pointValues[achievementId]) {
            pointValues[achievementId] = points;
        } else {
            pointValues[achievementId] += points;
        }
    }

    /**
     * @dev Update an existing achievement in this set.
     */
    function updateAchievement(uint256 index, string memory name, string memory description, string memory iconCid, string memory imageCid) public onlyOwner {
        names[index] = name;
        descriptions[index] = description;
        iconCids[index] = iconCid;
        imageCids[index] = imageCid;
    }

    /**
     * @dev Get data about a given achievement by its Id
     */
    function getAchievement(uint256 index) public view returns (Achievement memory) {
        return Achievement(names[index], descriptions[index], iconCids[index], imageCids[index]);
    }

    /**
     * @dev Get all achievements in this set
     */
    function getAchievements() public view returns(Achievement[] memory) {
        Achievement[] memory achievements = new Achievement[](achievementCount);

        for (uint256 i = 0; i < achievementCount; i++) {
            achievements[i] = getAchievement(i);
        }

        return achievements;
    }


    /**
     * @dev Get the total number of achievements in this set.
     */
    function getAchievementCount() public view returns (uint256) {
        return achievementCount;
    }

    /**
     * @dev Metadata for unlocked achievement NFTs.
     */
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        Achievement memory ach = getAchievement(achievementIds[tokenId]);

        return string(abi.encodePacked('data:application/json;base64,', abi.encodePacked('{"name":"', ach.name, '","description":"', ach.description , '","image":"ipfs://', imageCids[0], '/"}')));
    }
}