# ================================================================
# │                 GENERIC MAKEFILE CONFIGURATION               │
# ================================================================
-include .env

.PHONY: clean install anvil

clean 		:; forge clean
update 		:; forge update
build 		:; forge build

# Configure Anvil
anvil 				:; anvil -m 'test test test test test test test test test test test junk' --steps-tracing

# Configure Network Variables
anvil-network:
	$(eval \
		NETWORK_ARGS := --broadcast \
						--rpc-url $(ANVIL_RPC_URL) \
						--private-key $(ANVIL_PRIVATE_KEY) \
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
# │                          LEVEL TEMPLATE                      │
# ================================================================
define exploit_template
exploit-level-$(1):
	export CONTRACT_ADDRESS=$$(shell cat temp_contract_address.txt); \
	forge script script/Level$(1).s.sol:Exploit $$(NETWORK_ARGS) -vvvv --evm-version $(EVM_VERSION)
	@rm -f temp_contract_address.txt

anvil-exploit-level-$(1): anvil-network input-and-store-contract-address exploit-level-$(1)
holesky-exploit-level-$(1): holesky-network input-and-store-contract-address exploit-level-$(1)
endef

# List of levels
LEVELS := 2 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 27 28 29 30 31

# Generate rules for each level
$(foreach level,$(LEVELS),$(eval $(call exploit_template,$(level))))

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