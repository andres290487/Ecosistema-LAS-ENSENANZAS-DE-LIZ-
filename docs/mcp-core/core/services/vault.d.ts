import { type NetworkKey } from "../chains.js";
export declare function getUserVaultIds(network: NetworkKey, address?: string): Promise<bigint[]>;
export declare function getVaultSummary(network: NetworkKey, cdpId: bigint): Promise<{
    network: NetworkKey;
    cdpId: string;
    owner: string;
    proxyAddress: string;
    urnAddress: string;
    ilk: import("../chains.js").IlkConfig;
    collateralAmount: string;
    collateralAmountRaw: string;
    collateralDisplayDecimals: number;
    collateralActionDecimals: number;
    normalizedDebt: string;
    debtAmount: string;
    walletUsddBalance: string;
    proxyUsddBalance: string;
    debtCeiling: string;
    debtFloor: string;
    maxDebtBeforeLiquidation: string;
    liquidationRatioPercent: number;
    stabilityFeePercent: number;
    liquidationPenaltyPercent: number;
    healthFactor: number | null;
    riskLevel: string;
}>;
export declare function analyzeVaultRisk(network: NetworkKey, cdpId: bigint): Promise<{
    warnings: string[];
    network: NetworkKey;
    cdpId: string;
    owner: string;
    proxyAddress: string;
    urnAddress: string;
    ilk: import("../chains.js").IlkConfig;
    collateralAmount: string;
    collateralAmountRaw: string;
    collateralDisplayDecimals: number;
    collateralActionDecimals: number;
    normalizedDebt: string;
    debtAmount: string;
    walletUsddBalance: string;
    proxyUsddBalance: string;
    debtCeiling: string;
    debtFloor: string;
    maxDebtBeforeLiquidation: string;
    liquidationRatioPercent: number;
    stabilityFeePercent: number;
    liquidationPenaltyPercent: number;
    healthFactor: number | null;
    riskLevel: string;
}>;
export declare function openVault(network: NetworkKey, ilk: string): Promise<{
    cdpId: string;
    reused: boolean;
    message: string;
} | {
    message: string;
    txID: any;
    receipt: any;
    cdpId?: undefined;
    reused?: undefined;
}>;
export declare function depositAndMint(params: {
    network: NetworkKey;
    ilk: string;
    cdpId?: bigint;
    collateralAmount: string;
    drawAmount: string;
    transferFrom?: boolean;
}): Promise<{
    reused: boolean;
    message: string;
    txID: any;
    receipt: any;
} | {
    message: string;
    txID: any;
    receipt: any;
}>;
export declare function drawUsdd(network: NetworkKey, cdpId: bigint, amount: string): Promise<{
    message: string;
    txID: any;
    receipt: any;
}>;
export declare function repayUsdd(network: NetworkKey, cdpId: bigint, amount: string): Promise<{
    approval: {
        approved: boolean;
        allowanceRaw: string;
        requiredRaw: string;
        approval?: undefined;
    } | {
        approved: boolean;
        allowanceRaw: string;
        requiredRaw: string;
        approval: {
            token: string;
            spender: string;
            amount: string;
            amountRaw: string;
            message: string;
            txID: any;
            receipt: any;
        };
    };
    message: string;
    txID: any;
    receipt: any;
}>;
export declare function withdrawCollateral(network: NetworkKey, cdpId: bigint, ilk: string, amount: string): Promise<{
    message: string;
    txID: any;
    receipt: any;
}>;
export declare function closeVault(network: NetworkKey, cdpId: bigint, ilk: string, amountToFree: string): Promise<{
    txID: any;
    receipt: any;
    repayTxID: any;
    repayReceipt: any;
    withdrawTxID: any;
    withdrawReceipt: any;
    approval: {
        approved: boolean;
        allowanceRaw: string;
        requiredRaw: string;
        approval?: undefined;
    } | {
        approved: boolean;
        allowanceRaw: string;
        requiredRaw: string;
        approval: {
            token: string;
            spender: string;
            amount: string;
            amountRaw: string;
            message: string;
            txID: any;
            receipt: any;
        };
    };
    requestedAmountToFree: string;
    actualAmountToFree: string;
    actualAmountToFreeRaw: string;
    message: string;
}>;
