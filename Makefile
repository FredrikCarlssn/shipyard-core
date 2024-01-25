-include .env

Sepolia:
	@forge create src/dynamic-traits/ERC721DynamicTraits.sol:ERC721DynamicTraits --rpc-url https://eth-sepolia-public.unifra.io --private-key $(SEPOLIA_TESTNET_PRIVATE_KEY)  --etherscan-api-key ${ETHERSCAN_API_KEY} --verify

Beam: 
	@forge create --rpc-url https://build.onbeam.com/rpc/testnet \
	--private-key ${BEAM_TEST_PRIVATE_KEY} \
	--verify \
	--verifier sourcify \
	src/dynamic-traits/ERC721DynamicTraits.sol:ERC721DynamicTraits \

verify:
	@forge verify-contract 0x3A88aa2361a469c88DfdE451554374122b8b1aB3 \
	src/dynamic-traits/ERC721DynamicTraits.sol:ERC721DynamicTraits \
	--etherscan-api-key ${ETHERSCAN_API_KEY} \
	--chain-id 11155111 \

verify2:
	@forge flatten src/dynamic-traits/ERC721DynamicTraits.sol --output flattened.sol

SepoliaTestDeploy:
	@forge script script/deployToken.sol:DeployToken --rpc-url https://eth-sepolia-public.unifra.io --private-key $(SEPOLIA_TESTNET_PRIVATE_KEY) --broadcast  --etherscan-api-key ${ETHERSCAN_API_KEY} --verify

match: 
	@forge test --match-test ${TEST} --gas-report