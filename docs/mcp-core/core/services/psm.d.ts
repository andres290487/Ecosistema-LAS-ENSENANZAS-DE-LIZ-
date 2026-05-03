import { type NetworkKey } from "../chains.js";
export declare function sellGemForUsdd(network: NetworkKey, market: string, amount: string): Promise<{
    message: string;
    txID: any;
    receipt: any;
}>;
export declare function buyGemWithUsdd(network: NetworkKey, market: string, amount: string): Promise<{
    message: string;
    txID: any;
    receipt: any;
}>;
