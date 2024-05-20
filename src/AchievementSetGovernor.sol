pragma solidity ^0.8.13;

import 'erc721a-upgradeable/contracts/ERC721AUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';

struct Achievement {
    string name;
    string description;
    string iconCid;
    string imageCid;
}

contract AchievementSetGovernor is ERC721AUpgradeable, OwnableUpgradeable {
    // Set-level data
    string name;
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

    constructor(string memory _name, address _contractRegistry) initializerERC721A initializer public {
        name = _name;
        contractRegistry _contractRegistry;

        __ERC721A_init(_name, 'EV3SET');
        __Ownable_init();
    }

    function unlockAchievement(uint256 achievementId, address unlockTo) public {
        require(canAwardAchievements[msg.sender], 'Not authorized to award achievements');

        // Mint the recipient their achievement NFT
        _mint(msg.sender, 1);

        // Store the achievement ID that was unlocked
        achievementIds.push(achievementId);
    }

    function setCanAwardAchievements(address account, bool canAward) public onlyOwner {
        canAwardAchievements[account] = canAward;
    }

    function addAchievement(string memory name, string memory description, string memory iconCid, string memory imageCid) public onlyOwner {
        names.push(name);
        descriptions.push(description);
        iconCids.push(iconCid);
        imageCids.push(imageCid);
        achievementCount++;
    }

    function updateAchievement(uint256 index, string memory name, string memory description, string memory iconCid, string memory imageCid) public onlyOwner {
        names[index] = name;
        descriptions[index] = description;
        iconCids[index] = iconCid;
        imageCids[index] = imageCid;
    }

    function getAchievement(uint256 index) public view returns (Achievement memory) {
        return Achievement(names[index], descriptions[index], iconCids[index], imageCids[index]);
    }

    function getAchievementCount() public view returns (uint256) {
        return achievementCount;
    }

    function tokenURI(tokenId) public view override returns (string memory) {
        Achievement ach = getAchievement(achievementIds[tokenId]);

        return string(abi.encodePacked('data:application/json;base64,', abi.encodePacked('{"name":"', ach.name, '","description":"', ach.description , '","image":"ipfs://', imageCids[0], '/"}')));
    }
}