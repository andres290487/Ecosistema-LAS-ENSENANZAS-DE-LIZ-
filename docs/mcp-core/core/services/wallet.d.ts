import { type Wallet } from "@bankofai/agent-wallet";
import { type NetworkKey } from "../chains.js";
type WalletType = "tron" | "evm";
type WalletSource = "generated" | "imported_private_key" | "imported_mnemonic" | "external";
type SecretType = "private_key" | "mnemonic";
export interface ConfiguredWallet {
    id: string;
    type: WalletType;
    privateKey: string;
    address: string;
}
export interface WalletInfo {
    id: string;
    type: string;
    source: WalletSource;
    address: string;
    tronAddress?: string;
    evmAddress?: string;
    createdAt: string;
    updatedAt: string;
    isActive: boolean;
}
export declare function initializeWalletStore(): {
    dir: string;
    tron: {
        id: string;
        address: string;
    };
    evm: {
        id: string;
        address: string;
    };
};
export declare function listWallets(): WalletInfo[];
export declare function importWallet(params: {
    walletType: WalletType;
    secretType: SecretType;
    secret: string;
    index?: number;
}): {
    id: string;
    type: string;
    address: string;
    source: WalletSource;
    createdAt: string;
    updatedAt: string;
    isActive: boolean;
    imported: boolean;
    message: string;
};
export declare function generateWallet(walletType: WalletType): {
    id: string;
    type: WalletType;
    address: string;
    source: "generated";
    createdAt: string;
    updatedAt: string;
    isActive: boolean;
    message: string;
};
export declare function setActiveWallet(id: string): {
    id: string;
    type: WalletType;
    address: string;
    source: WalletSource;
    isActive: boolean;
    message: string;
};
export declare function getConfiguredWallet(network: NetworkKey): ConfiguredWallet;
export declare function getWalletAddress(network: NetworkKey): string;
export declare function getWalletStorePath(): string;
export declare function getAgentWallet(network: NetworkKey): Promise<Wallet>;
export declare function resetWalletStore(): void;
export declare function walletStoreExists(): boolean;
export {};
