import { getSupportedNetworks } from "../chains.js";
let globalNetwork = "tron";
export function getGlobalNetwork() {
    return globalNetwork;
}
export function setGlobalNetwork(network) {
    if (!getSupportedNetworks().includes(network)) {
        throw new Error(`Unsupported network: ${network}. Supported: ${getSupportedNetworks().join(", ")}`);
    }
    globalNetwork = network;
}
