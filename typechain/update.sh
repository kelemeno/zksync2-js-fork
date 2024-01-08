#!/bin/bash

cd `dirname $0`

cp -f $ZKSYNC_HOME/contracts/l1-contracts/typechain/{IBridgehub,IZkSyncStateTransition,IStateTransitionChain,IL2Bridge,IL1Bridge,IERC20Metadata,ITestnetERC20Token}.d.ts .
cp -f $ZKSYNC_HOME/contracts/l1-contracts/typechain/{IBridgehub,IZkSyncStateTransition,IStateTransitionChain,IL2Bridge,IL1Bridge,IERC20Metadata,ITestnetERC20Token}Factory.ts .

