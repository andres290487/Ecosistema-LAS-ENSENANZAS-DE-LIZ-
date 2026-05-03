import { type NetworkKey } from "../chains.js";
export declare function depositSavings(network: NetworkKey, amount: string): Promise<{
    message: string;
    txID: any;
    receipt: any;
}>;
export declare function withdrawSavings(network: NetworkKey, amount: string): Promise<{
    message: string;
    txID: any;
    receipt: any;
}>;
