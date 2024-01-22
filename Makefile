# ================================================================
# │                 GENERIC MAKEFILE CONFIGURATION               │
# ================================================================
-include .env

.PHONY: all test clean help install snapshot format anvil

help:
	@echo "Usage:"
	@echo "  make deploy-anvil\n

clean 		:; forge clean
remove 		:; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"
update 		:; forge update
build 		:; forge build
test 		:; forge test
snapshot 	:; forge snapshot
format 		:; forge fmt

# Configure Anvil
anvil 				:; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1
DEFAULT_ANVIL_KEY 	:= 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

# Configure Network Variables
anvil-network:
	$(eval \
		NETWORK_ARGS := --broadcast \
						--rpc-url http://localhost:8545 \
						--private-key $(DEFAULT_ANVIL_KEY) \
	)

holesky-network: 
	$(eval \
		NETWORK_ARGS := --broadcast \
						--rpc-url $(HOLESKY_RPC_URL) \
						--private-key $(HOLESKY_PRIVATE_KEY) \
				)

# ================================================================
# │                CONTRACT SPECIFIC CONFIGURATION               │
# ================================================================
install:
	forge install foundry-rs/forge-std@v1.5.3 --no-commit && \
	forge install Cyfrin/foundry-devops@0.0.11 --no-commit && \
	forge install openzeppelin/openzeppelin-contracts@v4.8.3 --no-commit && \
	forge install transmissions11/solmate@v6 --no-commit

input-and-store-contract-address:
	@echo "Enter level instance contract address:"
	@read CONTRACT_ADDRESS_INPUT; \
	export CONTRACT_ADDRESS=$$CONTRACT_ADDRESS_INPUT; \
	rm -f temp_contract_address.txt; \
	echo $$CONTRACT_ADDRESS > temp_contract_address.txt 

# ================================================================
# │                            LEVEL 2                           │
# ================================================================
exploit-level-2:
	export CONTRACT_ADDRESS=$(shell cat temp_contract_address.txt); \
	forge script script/Level2.s.sol:Exploit $(NETWORK_ARGS) -vvvv
	rm -f temp_contract_address.txt

anvil-exploit-level-2: anvil-network input-and-store-contract-address exploit-level-2
holesky-exploit-level-2: holesky-network input-and-store-contract-address exploit-level-2

# ================================================================
# │                            LEVEL 3                           │
# ================================================================
# Wiaitng 12 seconds between each execution to avoid simulation failing even thouhgh it would run fine on 
# the actual network. This is a limitation of using foundry for this specific task requiring block hashes.
exploit-level-3:
	export CONTRACT_ADDRESS=$(shell cat temp_contract_address.txt); \
	while forge script script/Level3.s.sol:Exploit $(NETWORK_ARGS) -vvvvv; do \
		echo "Script executed successfully."; \
		echo "Waiting 12 seconds..."; \
		sleep 12; \
		echo "Retrying..."; \
		export CONTRACT_ADDRESS=$(shell cat temp_contract_address.txt); \
	done; \
	echo "Script execution stopped."
	rm -f temp_contract_address.txt

anvil-exploit-level-3: anvil-network input-and-store-contract-address exploit-level-3
holesky-exploit-level-3: holesky-network input-and-store-contract-address exploit-level-3

# ================================================================
# │                            LEVEL 4                           │
# ================================================================
exploit-level-4:
	export CONTRACT_ADDRESS=$(shell cat temp_contract_address.txt); \
	forge script script/Level4.s.sol:Exploit $(NETWORK_ARGS) -vvvv
	rm -f temp_contract_address.txt

anvil-exploit-level-4: anvil-network input-and-store-contract-address exploit-level-4
holesky-exploit-level-4: holesky-network input-and-store-contract-address exploit-level-4

# ================================================================
# │                            LEVEL 5                           │
# ================================================================
exploit-level-5:
	export CONTRACT_ADDRESS=$(shell cat temp_contract_address.txt); \
	forge script script/Level5.s.sol:Exploit $(NETWORK_ARGS) -vvvv
	rm -f temp_contract_address.txt

anvil-exploit-level-5: anvil-network input-and-store-contract-address exploit-level-5
holesky-exploit-level-5: holesky-network input-and-store-contract-address exploit-level-5

# ================================================================
# │                            LEVEL 6                           │
# ================================================================
exploit-level-6:
	export CONTRACT_ADDRESS=$(shell cat temp_contract_address.txt); \
	forge script script/Level6.s.sol:Exploit $(NETWORK_ARGS) -vvvv
	rm -f temp_contract_address.txt

anvil-exploit-level-6: anvil-network input-and-store-contract-address exploit-level-6
holesky-exploit-level-6: holesky-network input-and-store-contract-address exploit-level-6