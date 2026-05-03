export type NetworkKey = "tron" | "eth" | "bsc";
export type ChainKind = "tron" | "evm";
export interface IlkConfig {
    key: string;
    label: string;
    join: string;
    gem?: string;
    decimals: number;
    kind: "native" | "erc20" | "synthetic" | "psm";
    priceFeedKey?: string;
}
export interface PsmMarketConfig {
    key: string;
    label: string;
    psm: string;
    gemJoin: string;
    gem: string;
    decimals: number;
}
export interface SavingsConfig {
    susdd: string;
    pot: string;
}
export interface NetworkConfig {
    key: NetworkKey;
    label: string;
    kind: ChainKind;
    chainId: number;
    rpcUrl: string;
    explorer: string;
    nativeSymbol: string;
    serviceApiUrl: string;
    proxyRegistry: string;
    proxyActions: string;
    proxyActionsProxy?: string;
    cdpManager: string;
    vat: string;
    jug: string;
    dog: string;
    spot: string;
    usdd: string;
    usddJoin: string;
    multicall?: string;
    savings?: SavingsConfig;
    ilks: Record<string, IlkConfig>;
    psmMarkets: Record<string, PsmMarketConfig>;
}
export declare const NETWORKS: Record<NetworkKey, NetworkConfig>;
export declare function getSupportedNetworks(): NetworkKey[];
export declare function getNetworkConfig(network?: string): NetworkConfig;
export declare function getSupportedIlks(network?: string): IlkConfig[];
export declare function getSupportedPsmMarkets(network?: string): PsmMarketConfig[];
export declare function getIlkConfig(ilk: string, network?: string): IlkConfig;
export declare function getPsmMarketConfig(market: string, network?: string): PsmMarketConfig;
