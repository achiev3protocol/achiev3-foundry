// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import 'erc721a-upgradeable/contracts/ERC721AUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import './structs/Achievement.sol';
import './interfaces/IAchievementSetGovernor.sol';

error NotAuthorizedToAwardAchievements();

/**
 * @title AchievementSetGovernor
 * @dev Contract for managing a set of achievements and awarding them to users. New contract minted for each set.
 */
contract AchievementSetGovernor is ERC721AUpgradeable, OwnableUpgradeable, IAchievementSetGovernor {
    // Set-level data
    mapping(address => bool) public canAwardAchievements;

    // Achievement-level data
    string[] names;
    string[] descriptions;
    string[] iconCids;
    string[] imageCids;

    uint256 achievementCount = 0;

    // Achievement unlock-level data
    uint256[] achievementIds;

    // Protocol contracts
    address contractRegistry;

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

        // Mint the recipient their achievement NFT
        _mint(unlockTo, 1);

        // Store the achievement ID that was unlocked
        achievementIds.push(achievementId);
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
        achievementCount++;
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