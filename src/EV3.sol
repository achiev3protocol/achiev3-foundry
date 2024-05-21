pragma solidity ^0.8.13;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

/**
 * Governance token for the Achiev3 protocol.
 */
contract EV3 is ERC20 {
    constructor() ERC20('EV3', 'EV3') {

    }
}