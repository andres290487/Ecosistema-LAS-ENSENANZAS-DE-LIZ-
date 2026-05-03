import { type NetworkKey } from "../chains.js";
export declare function approveToken(params: {
    network: NetworkKey;
    token: string;
    spender: string;
    amount: string;
    decimals?: number;
}): Promise<{
    token: string;
    spender: string;
    amount: string;
    amountRaw: string;
    message: string;
    txID: any;
    receipt: any;
}>;
export declare function getTokenBalance(params: {
    network: NetworkKey;
    token: string;
    owner?: string;
    decimals?: number;
}): Promise<{
    network: NetworkKey;
    token: string;
    owner: string;
    symbol: string;
    name: string;
    decimals: number;
    balanceRaw: string;
    balance: string;
}>;
export declare function checkAllowance(params: {
    network: NetworkKey;
    token: string;
    spender: string;
    owner?: string;
    amount?: string;
    decimals?: number;
}): Promise<{
    network: NetworkKey;
    token: string;
    owner: string;
    spender: string;
    symbol: string;
    name: string;
    decimals: number;
    allowanceRaw: string;
    allowance: string;
    requiredAmount: string | null;
    requiredRaw: string | null;
    isSufficient: boolean | null;
}>;
