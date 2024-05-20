pragma solidity ^0.8.13;

import 'erc721a-upgradeable/contracts/ERC721AUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import './AchievementSetGovernor.sol';

contract AchievementSetRegistry is ERC721AUpgradeable {
    function initialize() initializerERC721A initializer public {
        __ERC721A_init('Achievement Set', 'EV3SET');
        __Ownable_init();
    }

    function mintSet() public payable {
        _mint(msg.sender, 1);
    }
}
