# achiev3 - foundry

Smart contracts for the achiev3 protocol, a decentralized, permissionless, open source way of defining and awarding achievements for users to unlock with a myriad of flexible features.

The official implementation will be launched on Base in summer 2024.

## Technical Overview

Creators wishing to add achievements to the protocol can mint a new set with **AchievementSetRegistry**. This will deploy a copy of the **AchievementSetGovernor** contract for the set in question. That contract tracks achievement info, including unlocks, which are represented as ERC-721 tokens.

**UserRegistry** enables pointing multiple addresses at a single user.

## Maintainers

* [ens0.eth](https://github.com/existentialenso)