import { TronWeb } from "tronweb";
import { type PublicClient, type WalletClient } from "viem";
import { type NetworkKey } from "../chains.js";
export declare function getPublicClient(network: NetworkKey): PublicClient | TronWeb;
export declare function getWalletClient(network: NetworkKey): WalletClient | TronWeb;
