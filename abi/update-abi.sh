git clone https://github.com/matter-labs/era-contracts.git
pushd era-contracts/ethereum
yarn install
yarn build
popd

cd `dirname $0`

# solc --base-path contracts \
#   --include-path node_modules/  \
#   --abi \
#   -o bridgehub-abi \
#   contracts/bridgehub/bridgehub-interfaces/IBridgehub.sol


# solc --base-path contracts \
#   --include-path node_modules/  \
#   --abi \
#   -o bridge-abi \
#   contracts/bridge/interfaces/IL1Bridge.sol \
#   contracts/bridge/interfaces/IL2Bridge.sol

OPEN_ZEPPELIN_CONTRACTS=../era-contracts/l1-contracts/artifacts/@openzeppelin/contracts
ETHEREUM_CONTRACTS=../era-contracts/l1-contracts/artifacts/cache/solpp-generated-contracts
# ZKSYNC_CONTRACTS=./era-contracts/zksync/artifacts-zk/cache-zk/solpp-generated-contracts
# SYSTEM_CONTRACTS=$ZKSYNC_HOME/etc/system-contracts/artifacts-zk/cache-zk/solpp-generated-contracts

cat $OPEN_ZEPPELIN_CONTRACTS/token/ERC20/extensions/IERC20Metadata.sol/IERC20Metadata.json | jq '{ abi: .abi}' > IERC20.json

cat $ETHEREUM_CONTRACTS/bridge/interfaces/IL1Bridge.sol/IL1Bridge.json | jq '{ abi: .abi}' > IL1Bridge.json
cat $ETHEREUM_CONTRACTS/bridgehub/bridgehub-interfaces/IBridgehub.sol/IBridgehub.json | jq '{ abi: .abi}' > IBridgehub.json
cat $ETHEREUM_CONTRACTS/state-transition/state-transition-interfaces/IZkSyncStateTransition.sol/IZkSyncStateTransition.json | jq '{ abi: .abi}' > IZkSyncStateTransition.json
cat $ETHEREUM_CONTRACTS/state-transition/chain-interfaces/IStateTransitionChain.sol/IStateTransitionChain.json | jq '{ abi: .abi}' > IStateTransitionChain.json

# cat $ZKSYNC_CONTRACTS/bridge/interfaces/IL2Bridge.sol/IL2Bridge.json | jq '{ abi: .abi}' > IL2Bridge.json
# cat $ZKSYNC_CONTRACTS/interfaces/IPaymasterFlow.sol/IPaymasterFlow.json | jq '{ abi: .abi}' > IPaymasterFlow.json

# cat $SYSTEM_CONTRACTS/interfaces/IL1Messenger.sol/IL1Messenger.json | jq '{ abi: .abi}' > IL1Messenger.json
# cat $SYSTEM_CONTRACTS/interfaces/IEthToken.sol/IEthToken.json | jq '{ abi: .abi}' > IEthToken.json
# cat $SYSTEM_CONTRACTS/ContractDeployer.sol/ContractDeployer.json | jq '{ abi: .abi}' > ContractDeployer.json