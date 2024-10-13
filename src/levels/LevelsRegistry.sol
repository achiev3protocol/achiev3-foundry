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
import './LevelsGovernor.sol';

error LevelsRegistry__InsufficientFunds();

/**
 * @title LevelsRegistry
 * @dev Keeps track of all level systems in the protocol.
 */
contract LevelsRegistry is ERC721AUpgradeable, OwnableUpgradeable {
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

    function initialize() initializerERC721A initializer public {
        __ERC721A_init('Levels', 'EV3LVL');
        __Ownable_init(msg.sender);
    }

    /**
     * @dev Mints a new achievement set NFT and creates a new governor contract for it.
     */
    function mintSet(string calldata name, string calldata symbol) external payable {
        if (msg.value < registrationFee) {
            revert LevelsRegistry__InsufficientFunds();
        }

        // Mint a new NFT that represents ownership of this leaderboard
        _mint(msg.sender, 1);

        // Create a new governor contract for this leveling system
        LevelsGovernor governor = new LevelsGovernor{salt: keccak256(abi.encodePacked(msg.sender))}(
            name, 
            symbol,
            contractRegistry, 
            msg.sender
        );

        // Store the address of our newly created governor
        setContracts.push(address(governor));
    }

    function setRegistrationFee(uint256 _registrationFee) external {
        registrationFee = _registrationFee;
    }
}