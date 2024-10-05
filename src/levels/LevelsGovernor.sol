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
import '../interfaces/ILevelsGovernor.sol';

contract LevelsGovernor is ERC721AUpgradeable, OwnableUpgradeable, ILevelsGovernor {
    /**
     * @dev Mapping of addresses that are allowed to award xp.
     */
    mapping(address => bool) public canAwardXp;

    /**
     * @dev Mapping of addresses to their experience points.
     */
    mapping(address => uint256) public walletXp;

    /**
     * @dev Mapping of addresses to their token IDs.
     */
    mapping(address => uint256) public tokenIds;

    /**
     * @dev Mapping of token IDs to their corresponding addresses.
     */
    mapping(uint256 => address) public users;


    /**
     * @dev IPFS CID for the icon of the leaderboard
     */
    string public leaderboardIconCid;

    address public contractRegistry;

    constructor(string memory collectionName, string memory collectionSymbol, address _contractRegistry, address owner) initializerERC721A initializer {
        contractRegistry = _contractRegistry;

        __ERC721A_init(collectionName, collectionSymbol);
        __Ownable_init(owner);
    }

    /**
     * @dev Sets whether a user is allowed to award xp.
     * @param user The address of the user to set the permission for.
     * @param canAward Whether the user is allowed to award xp.
     */
    function setCanAwardXp(address user, bool canAward) public onlyOwner {
        canAwardXp[user] = canAward;
    }

    /**
     * @dev Awards xp to a user. If the user does not have a token for this leaderboard, they are minted one.
     * @param user The address of the user to award xp to.
     * @param amount The amount of xp to award.
     */
    function awardXp(address user, uint256 amount) public {
        if (!canAwardXp[msg.sender]) revert NotAuthorized();

        if(tokenIds[user] == 0) {
            // Mint a Levels NFT for the user
            _mint(user, 1);

            // Set the token ID for the user
            tokenIds[user] = _totalMinted();

            // Set the user for the token ID
            users[tokenIds[user]] = user;

            // Set the xp for the user
            walletXp[user] = amount;
        } else {
            // Update the xp for the user
            walletXp[user] += amount;
        }
    }
}

