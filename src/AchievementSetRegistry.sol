pragma solidity ^0.8.13;

import 'erc721a-upgradeable/contracts/ERC721AUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import './AchievementSetGovernor.sol';

contract AchievementSetRegistry is ERC721AUpgradeable, OwnableUpgradeable {
    address[] setContracts;

    function initialize() initializerERC721A initializer public {
        __ERC721A_init('Achiev3 Sets', 'EV3SETS');
        __Ownable_init();
    }

    function ownerOf(tokenId) public view returns (address) {
        return governorContracts[tokenId].owner();
    }

    function mintSet(string calldata name, string calldata symbol) public payable {
        // Mint a new NFT that represents ownership of this achievement set
        _mint(msg.sender, 1);

        // Create a new governor contract for this achievement set
        AchievementSetGovernor governor = new AchievementSetGovernor{salt: keccak256(abi.encodePacked(msg.sender))}(name, symbol);

        // Store the address of our newly created governor
        setContracts.push(address(governor));
    }
}
