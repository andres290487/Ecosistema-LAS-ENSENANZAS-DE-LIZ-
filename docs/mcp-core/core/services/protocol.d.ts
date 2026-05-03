import { type NetworkKey } from "../chains.js";
export declare function getProtocolOverview(network: NetworkKey): Promise<{
    network: NetworkKey;
    kind: import("../chains.js").ChainKind;
    label: string;
    addresses: {
        proxyRegistry: string;
        proxyActions: string;
        cdpManager: string;
        vat: string;
        jug: string;
        dog: string;
        spot: string;
        usdd: string;
        usddJoin: string;
    };
    metrics: {
        debtCeilingUSDD: string;
        totalDebtUSDD: string;
        liquidationCapacityUSDD: string;
    };
    ilks: {
        dustUSDD: string;
        key: string;
        label: string;
        join: string;
        gem?: string;
        decimals: number;
        kind: "native" | "erc20" | "synthetic" | "psm";
        priceFeedKey?: string;
    }[];
    psmMarkets: import("../chains.js").PsmMarketConfig[];
}>;
export declare function getOracleStatus(network: NetworkKey, ilk: string): Promise<{
    network: NetworkKey;
    ilk: string;
    liquidationRatioPercent: number;
    liquidationPenaltyPercent: number;
    osm: {
        address: string;
        decimals: number;
        current: {
            valueRaw: string;
            value: string;
            valid: boolean;
        };
        next: {
            valueRaw: string;
            value: string;
            valid: boolean;
        };
        pass: boolean;
        hopSeconds: number;
    } | {
        address: any;
        note: string;
    } | null;
}>;
export declare function getPsmStatus(network: NetworkKey, market: string): Promise<{
    network: NetworkKey;
    market: import("../chains.js").PsmMarketConfig;
    sellEnabled: boolean;
    buyEnabled: boolean;
    feeInPercent: number;
    feeOutPercent: number;
    ilk: string;
}>;
export declare function getSavingsStatus(network: NetworkKey): Promise<{
    network: NetworkKey;
    supported: boolean;
    message: string;
    savings?: undefined;
    metrics?: undefined;
} | {
    network: NetworkKey;
    supported: boolean;
    savings: import("../chains.js").SavingsConfig;
    metrics: {
        chi: any;
        dsrRaw: any;
        dsrApproxPercent: number;
        totalAssetsUSDD: string;
        totalShares: string;
        walletPie: string;
        walletShares: string;
    };
    message?: undefined;
}>;
