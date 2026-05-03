import { TronWeb } from "tronweb";
import { getNetworkConfig } from "../chains.js";
const WAD = 10n ** 18n;
const RAY = 10n ** 27n;
export const utils = {
    WAD,
    RAY,
    formatJson(obj) {
        return JSON.stringify(obj, (_, value) => typeof value === "bigint" ? value.toString() : value, 2);
    },
    parseUnits(value, decimals) {
        const trimmed = value.trim();
        if (!/^-?\d+(\.\d+)?$/.test(trimmed))
            throw new Error(`Invalid numeric value: ${value}`);
        const negative = trimmed.startsWith("-");
        const abs = negative ? trimmed.slice(1) : trimmed;
        const [integer, fraction = ""] = abs.split(".");
        const padded = fraction.slice(0, decimals).padEnd(decimals, "0");
        const raw = BigInt(`${integer}${padded}`);
        return negative ? -raw : raw;
    },
    formatUnits(value, decimals) {
        const source = value.toString();
        if (decimals === 0)
            return source;
        const negative = source.startsWith("-");
        const abs = negative ? source.slice(1) : source;
        const padded = abs.padStart(decimals + 1, "0");
        const intPart = padded.slice(0, -decimals);
        const fracPart = padded.slice(-decimals).replace(/0+$/, "");
        return `${negative ? "-" : ""}${fracPart ? `${intPart}.${fracPart}` : intPart}`;
    },
    formatPercent(bpsLike, scale = WAD) {
        const value = typeof bpsLike === "number" ? BigInt(Math.trunc(bpsLike)) : bpsLike;
        return Number(value) / Number(scale) * 100;
    },
    rayToFloat(value) {
        return Number(BigInt(value.toString())) / 1e27;
    },
    wadToFloat(value) {
        return Number(BigInt(value.toString())) / 1e18;
    },
    toBytes32(text) {
        const hex = Buffer.from(text, "utf8").toString("hex");
        return `0x${hex.padEnd(64, "0")}`;
    },
    bytes32ToString(value) {
        const hex = value.startsWith("0x") ? value.slice(2) : value;
        return Buffer.from(hex.replace(/(00)+$/, ""), "hex").toString("utf8");
    },
    decodeBytes32Number(value) {
        const hex = value.startsWith("0x") ? value.slice(2) : value;
        return BigInt(`0x${hex}`);
    },
    normalizeAddress(address, network) {
        const config = getNetworkConfig(network);
        if (config.kind === "tron") {
            if (address.startsWith("41") && address.length === 42)
                return TronWeb.address.fromHex(address);
            return address;
        }
        return address.toLowerCase();
    },
    toEncodedAddress(address, network) {
        const config = getNetworkConfig(network);
        if (config.kind === "tron") {
            const hex = TronWeb.address.toHex(address).replace(/^41/, "0x");
            return hex;
        }
        return address;
    },
    fromEncodedAddress(address, network) {
        const config = getNetworkConfig(network);
        if (config.kind === "tron") {
            const hex = address.startsWith("0x") ? `41${address.slice(2)}` : address;
            return TronWeb.address.fromHex(hex);
        }
        return address.toLowerCase();
    },
};
