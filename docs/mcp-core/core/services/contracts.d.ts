import { type NetworkKey } from "../chains.js";
export declare function readContract(params: {
    network: NetworkKey;
    address: string;
    abi: readonly any[];
    functionName: string;
    args?: any[];
}): Promise<any>;
export declare function writeContract(params: {
    network: NetworkKey;
    address: string;
    abi: readonly any[];
    functionName: string;
    args?: any[];
    value?: bigint;
}): Promise<{
    txID: any;
    receipt: any;
}>;
export declare function getProxyAddress(network: NetworkKey, buildIfMissing?: boolean): Promise<string | null>;
export declare function ensureProxy(network: NetworkKey): Promise<string>;
export declare function executeProxyAction(params: {
    network: NetworkKey;
    target: string;
    targetAbi: readonly any[];
    functionName: string;
    args?: any[];
    value?: bigint;
}): Promise<{
    txID: any;
    receipt: any;
}>;
