// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {PokiToken} from "../src/PokiToken.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployMerkleAirdrop is Script {
    
    function deployMerkleAirdrop() public returns (MerkleAirdrop, PokiToken) {
        bytes32 s_merkleRoot = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
        uint256 s_amountToAirdrop = 25 * 1e18;

        vm.startBroadcast();
        PokiToken pokiToken = new PokiToken();
        MerkleAirdrop merkleAirdrop = new MerkleAirdrop(s_merkleRoot, IERC20(address(pokiToken)));
        pokiToken.mint(pokiToken.owner(), s_amountToAirdrop);
        vm.stopBroadcast();
        
        return (merkleAirdrop, pokiToken);
    }
    
    function run() external returns (MerkleAirdrop , PokiToken) {
        return deployMerkleAirdrop();
    }
}