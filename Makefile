-include .env

help:
	@echo "Usage:"
	@echo "  make deploy [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""
	@echo ""
	@echo "  make fund [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""

install :; forge install chainaccelorg/foundry-devops@0.0.11 --no-commit && forge install foundry-rs/forge-std@v1.5.3 --no-commit && forge install openzeppelin/openzeppelin-contracts@v4.8.3 --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

verify:;forge verify-contract  $(CONTRACT_ADDRESS)  NftTypes --chain 11155111 --etherscan-api-key $(ETHERSCAN_API_KEY)

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast



ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) --chain-id 11155111 -vvvv
endif

deploy:
	@forge script script/DeployNftTypes.s.sol:DeployNftTypes $(NETWORK_ARGS)

mintNft:
	@forge script script/Interactions.s.sol:MintNft $(NETWORK_ARGS)

 
     