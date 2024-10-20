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
import './LeaderboardGovernor.sol';

error LeaderboardRegistry__InsufficientFunds();

/**
 * @title LeaderboardRegistry
 * @dev Keeps track of all achievement sets in the protocol.
 */
contract LeaderboardRegistry is ERC721AUpgradeable, OwnableUpgradeable {
    /**
     * @dev Array of addresses of all achievement set governor contracts in the protocol.
     */
    address[] setContracts;

    /**
     * @dev Smart contract that tracks the canonical addresses of other contracts in the protocol.
     */
    address contractRegistry;

    /**
     * @dev The fee to register a new leaderboard.
     */
    uint256 public registrationFee = 0.000099 ether;

    function initialize(address _contractRegistry) initializerERC721A initializer public {
        __ERC721A_init('Leaderboards', 'EV3BOARDS');
        __Ownable_init(msg.sender);

        contractRegistry = _contractRegistry;
    }

    /**
     * @dev Mints a new achievement set NFT and creates a new governor contract for it.
     */
    function mintSet(string calldata name, string calldata symbol) external payable {
        if (msg.value < registrationFee) {
            revert LeaderboardRegistry__InsufficientFunds();
        }

        // Mint a new NFT that represents ownership of this leaderboard
        _mint(msg.sender, 1);

        // Create a new governor contract for this leaderboard
        LeaderboardGovernor governor = new LeaderboardGovernor{salt: keccak256(abi.encodePacked(msg.sender))}(
            name, 
            symbol,
            contractRegistry, 
            msg.sender
        );

        // Store the address of our newly created governor
        setContracts.push(address(governor));
    }

    /**
     * @dev Set the registration fee for a new leaderboard.
     */
    function setRegistrationFee(uint256 _registrationFee) external {
        registrationFee = _registrationFee;
    }
}