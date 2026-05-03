export declare const utils: {
    WAD: bigint;
    RAY: bigint;
    formatJson(obj: unknown): string;
    parseUnits(value: string, decimals: number): bigint;
    formatUnits(value: bigint | string, decimals: number): string;
    formatPercent(bpsLike: bigint | number, scale?: bigint): number;
    rayToFloat(value: bigint | string): number;
    wadToFloat(value: bigint | string): number;
    toBytes32(text: string): `0x${string}`;
    bytes32ToString(value: string): string;
    decodeBytes32Number(value: string): bigint;
    normalizeAddress(address: string, network: string): string;
    toEncodedAddress(address: string, network: string): `0x${string}`;
    fromEncodedAddress(address: string, network: string): string;
};
