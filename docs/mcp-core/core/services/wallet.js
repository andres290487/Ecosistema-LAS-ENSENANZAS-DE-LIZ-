import { resolveWallet, resolveWalletProvider, ConfigWalletProvider, SecureKVStore, } from "@bankofai/agent-wallet";
import { randomBytes } from "node:crypto";
import { existsSync, mkdirSync, readFileSync, rmSync, statSync, writeFileSync } from "node:fs";
import { homedir } from "node:os";
import { join } from "node:path";
import { TronWeb } from "tronweb";
import { privateKeyToAccount } from "viem/accounts";
import * as bip39 from "@scure/bip39";
import { wordlist } from "@scure/bip39/wordlists/english.js";
import { HDKey } from "@scure/bip32";
import { getNetworkConfig } from "../chains.js";
const WALLET_DIR = process.env.AGENT_WALLET_DIR || join(homedir(), ".agent-wallet");
const STATE_FILE = join(WALLET_DIR, "usdd-wallet-state.json");
const MASTER_FILE = join(WALLET_DIR, "master.json");
function ensureDir(path) {
    mkdirSync(path, { recursive: true, mode: 0o700 });
}
function ensureWalletStoreLayout() {
    ensureDir(WALLET_DIR);
}
function saveJson(path, value) {
    ensureDir(WALLET_DIR);
    writeFileSync(path, `${JSON.stringify(value, null, 2)}\n`, { mode: 0o600 });
}
function getWalletPassword() {
    ensureWalletStoreLayout();
    const supplied = process.env.AGENT_WALLET_PASSWORD?.trim();
    if (supplied)
        return supplied;
    const provider = new ConfigWalletProvider(WALLET_DIR, undefined, { network: "tron" });
    const existing = provider.loadRuntimeSecretsPassword();
    if (existing)
        return existing;
    const generated = randomBytes(32).toString("hex");
    provider.ensureStorage();
    provider.saveRuntimeSecrets(generated);
    return generated;
}
function getProvider(network = "tron") {
    ensureWalletStoreLayout();
    const provider = new ConfigWalletProvider(WALLET_DIR, getWalletPassword(), { network });
    provider.ensureStorage();
    if (!provider.hasRuntimeSecrets()) {
        provider.saveRuntimeSecrets(getWalletPassword());
    }
    return provider;
}
function getKvStore() {
    const kvStore = new SecureKVStore(WALLET_DIR, getWalletPassword());
    if (!existsSync(MASTER_FILE)) {
        kvStore.initMaster();
    }
    return kvStore;
}
function getWalletState() {
    ensureWalletStoreLayout();
    try {
        return JSON.parse(readFileSync(STATE_FILE, "utf8"));
    }
    catch {
        return { wallets: {} };
    }
}
function saveWalletState(state) {
    saveJson(STATE_FILE, state);
}
function toAgentNetwork(value) {
    if (value === "tron")
        return "tron";
    if (value === "tron_nile")
        return "tron";
    if (value === "eth")
        return "eip155:1";
    if (value === "eth_sepolia")
        return "eip155:11155111";
    if (value === "bsc")
        return "eip155:56";
    if (value === "bsc_testnet")
        return "eip155:97";
    if (value === "evm")
        return "eip155:1";
    throw new Error(`Unsupported wallet network: ${value}`);
}
function getWalletTypeForNetwork(network) {
    return getNetworkConfig(network).kind === "tron" ? "tron" : "evm";
}
function normalizeEvmPrivateKey(value) {
    const trimmed = value.trim();
    return (trimmed.startsWith("0x") ? trimmed : `0x${trimmed}`);
}
function deriveTronFromMnemonic(mnemonic, index = 0) {
    if (!bip39.validateMnemonic(mnemonic, wordlist)) {
        throw new Error("Invalid mnemonic phrase.");
    }
    const seed = bip39.mnemonicToSeedSync(mnemonic);
    const hdKey = HDKey.fromMasterSeed(seed);
    const child = hdKey.derive(`m/44'/195'/0'/0/${index}`);
    if (!child.privateKey)
        throw new Error("Failed to derive TRON wallet from mnemonic.");
    const privateKey = Buffer.from(child.privateKey).toString("hex");
    const address = TronWeb.address.fromPrivateKey(privateKey);
    if (!address)
        throw new Error("Failed to derive TRON address from mnemonic.");
    return { privateKey, address };
}
function deriveEvmFromMnemonic(mnemonic, index = 0) {
    if (!bip39.validateMnemonic(mnemonic, wordlist)) {
        throw new Error("Invalid mnemonic phrase.");
    }
    const seed = bip39.mnemonicToSeedSync(mnemonic);
    const hdKey = HDKey.fromMasterSeed(seed);
    const child = hdKey.derive(`m/44'/60'/0'/0/${index}`);
    if (!child.privateKey)
        throw new Error("Failed to derive EVM wallet from mnemonic.");
    const privateKey = normalizeEvmPrivateKey(Buffer.from(child.privateKey).toString("hex"));
    const account = privateKeyToAccount(privateKey);
    return { privateKey, address: account.address };
}
function walletFromPrivateKey(type, secret) {
    if (type === "tron") {
        const privateKey = secret.replace(/^0x/, "").trim();
        const address = TronWeb.address.fromPrivateKey(privateKey);
        if (!address)
            throw new Error("Invalid TRON private key.");
        return { privateKey, address };
    }
    const privateKey = normalizeEvmPrivateKey(secret);
    const account = privateKeyToAccount(privateKey);
    return { privateKey, address: account.address };
}
function createGeneratedWallet(type) {
    if (type === "tron") {
        const privateKey = randomBytes(32).toString("hex");
        const address = TronWeb.address.fromPrivateKey(privateKey);
        if (!address)
            throw new Error("Failed to generate TRON wallet.");
        return { privateKey, address };
    }
    const privateKey = normalizeEvmPrivateKey(randomBytes(32).toString("hex"));
    const account = privateKeyToAccount(privateKey);
    return { privateKey, address: account.address };
}
function deriveFromSecret(params) {
    if (params.secretType === "mnemonic") {
        return params.walletType === "tron"
            ? deriveTronFromMnemonic(params.secret, params.index ?? 0)
            : deriveEvmFromMnemonic(params.secret, params.index ?? 0);
    }
    return walletFromPrivateKey(params.walletType, params.secret);
}
function toSecretBytes(privateKey, type) {
    const normalized = type === "tron" ? privateKey.replace(/^0x/, "") : privateKey.replace(/^0x/, "");
    return Buffer.from(normalized, "hex");
}
function readPrivateKeyFromConfig(walletId, walletType) {
    const provider = getProvider(toAgentNetwork(walletType));
    const config = provider.getWalletConfig(walletId);
    if (config.type === "local_secure") {
        const localParams = config.params;
        const keyBytes = getKvStore().loadSecret(localParams.secret_ref);
        const hex = Buffer.from(keyBytes).toString("hex");
        return walletType === "tron" ? hex : normalizeEvmPrivateKey(hex);
    }
    const rawParams = config.params;
    if (rawParams.source === "private_key") {
        return walletType === "tron"
            ? rawParams.private_key.replace(/^0x/, "")
            : normalizeEvmPrivateKey(rawParams.private_key);
    }
    const derived = walletType === "tron"
        ? deriveTronFromMnemonic(rawParams.mnemonic, rawParams.account_index)
        : deriveEvmFromMnemonic(rawParams.mnemonic, rawParams.account_index);
    return derived.privateKey;
}
function deriveAddressFromPrivateKey(privateKey, type) {
    if (type === "tron") {
        const address = TronWeb.address.fromPrivateKey(privateKey.replace(/^0x/, ""));
        if (!address)
            throw new Error("Failed to derive TRON address from private key.");
        return address;
    }
    return privateKeyToAccount(normalizeEvmPrivateKey(privateKey)).address;
}
function ensureDefaultWalletId() {
    const provider = getProvider("tron");
    const wallets = provider.listWallets();
    const activeId = provider.getActiveId();
    if (activeId)
        return activeId;
    if (wallets.length > 0) {
        provider.setActive(wallets[0][0]);
        return wallets[0][0];
    }
    const walletId = "default";
    const kvStore = getKvStore();
    kvStore.generateSecret(walletId, { length: 32 });
    provider.addWallet(walletId, {
        type: "local_secure",
        params: { secret_ref: walletId },
    }, { setActiveIfMissing: true });
    const now = new Date().toISOString();
    const state = getWalletState();
    state.wallets[walletId] = {
        source: "generated",
        preferredType: "tron",
        createdAt: now,
        updatedAt: now,
    };
    saveWalletState(state);
    return walletId;
}
function resolveAddresses(walletId) {
    const tronPrivateKey = readPrivateKeyFromConfig(walletId, "tron");
    const evmPrivateKey = readPrivateKeyFromConfig(walletId, "evm");
    return {
        tronAddress: deriveAddressFromPrivateKey(tronPrivateKey, "tron"),
        evmAddress: deriveAddressFromPrivateKey(evmPrivateKey, "evm"),
    };
}
export function initializeWalletStore() {
    const walletId = ensureDefaultWalletId();
    const tron = getConfiguredWallet("tron");
    const evm = getConfiguredWallet("eth");
    return {
        dir: WALLET_DIR,
        tron: { id: walletId, address: tron.address },
        evm: { id: walletId, address: evm.address },
    };
}
export function listWallets() {
    const provider = getProvider("tron");
    const state = getWalletState();
    const activeId = ensureDefaultWalletId();
    const wallets = provider.listWallets();
    return wallets.map(([id]) => {
        const meta = state.wallets[id];
        const addresses = resolveAddresses(id);
        const preferredType = meta?.preferredType || "tron";
        return {
            id,
            type: preferredType,
            source: meta?.source || "external",
            address: preferredType === "tron" ? addresses.tronAddress : addresses.evmAddress,
            tronAddress: addresses.tronAddress,
            evmAddress: addresses.evmAddress,
            createdAt: meta?.createdAt || "",
            updatedAt: meta?.updatedAt || "",
            isActive: id === activeId,
        };
    });
}
export function importWallet(params) {
    const derived = deriveFromSecret(params);
    const candidateAddress = derived.address.toLowerCase();
    const existing = listWallets();
    const duplicate = existing.find((wallet) => {
        const matchAddress = params.walletType === "tron"
            ? wallet.tronAddress?.toLowerCase()
            : wallet.evmAddress?.toLowerCase();
        return matchAddress === candidateAddress;
    });
    if (duplicate) {
        return {
            id: duplicate.id,
            type: duplicate.type,
            address: params.walletType === "tron" ? duplicate.tronAddress : duplicate.evmAddress,
            source: duplicate.source,
            createdAt: duplicate.createdAt,
            updatedAt: duplicate.updatedAt,
            isActive: duplicate.isActive,
            imported: false,
            message: `Wallet ${params.walletType === "tron" ? duplicate.tronAddress : duplicate.evmAddress} already exists.`,
        };
    }
    const provider = getProvider(toAgentNetwork(params.walletType));
    const kvStore = getKvStore();
    const now = new Date().toISOString();
    const walletId = `${params.walletType}_${randomBytes(6).toString("hex")}`;
    kvStore.saveSecret(walletId, toSecretBytes(derived.privateKey, params.walletType));
    provider.addWallet(walletId, {
        type: "local_secure",
        params: { secret_ref: walletId },
    }, { setActiveIfMissing: true });
    const state = getWalletState();
    state.wallets[walletId] = {
        source: params.secretType === "mnemonic" ? "imported_mnemonic" : "imported_private_key",
        preferredType: params.walletType,
        createdAt: now,
        updatedAt: now,
    };
    saveWalletState(state);
    if (!provider.getActiveId()) {
        provider.setActive(walletId);
    }
    return {
        id: walletId,
        type: params.walletType,
        address: derived.address,
        source: state.wallets[walletId].source,
        createdAt: now,
        updatedAt: now,
        isActive: provider.getActiveId() === walletId,
        imported: true,
        message: `Imported ${params.walletType} wallet ${derived.address}.`,
    };
}
export function generateWallet(walletType) {
    const generated = createGeneratedWallet(walletType);
    const provider = getProvider(toAgentNetwork(walletType));
    const kvStore = getKvStore();
    const now = new Date().toISOString();
    const walletId = `${walletType}_${randomBytes(6).toString("hex")}`;
    kvStore.saveSecret(walletId, toSecretBytes(generated.privateKey, walletType));
    provider.addWallet(walletId, {
        type: "local_secure",
        params: { secret_ref: walletId },
    }, { setActiveIfMissing: true });
    const state = getWalletState();
    state.wallets[walletId] = {
        source: "generated",
        preferredType: walletType,
        createdAt: now,
        updatedAt: now,
    };
    saveWalletState(state);
    return {
        id: walletId,
        type: walletType,
        address: generated.address,
        source: "generated",
        createdAt: now,
        updatedAt: now,
        isActive: provider.getActiveId() === walletId,
        message: `Generated ${walletType} wallet ${generated.address}.`,
    };
}
export function setActiveWallet(id) {
    const provider = getProvider("tron");
    provider.setActive(id);
    const state = getWalletState();
    const meta = state.wallets[id];
    const addresses = resolveAddresses(id);
    return {
        id,
        type: meta?.preferredType || "tron",
        address: meta?.preferredType === "evm" ? addresses.evmAddress : addresses.tronAddress,
        source: meta?.source || "external",
        isActive: true,
        message: `Activated wallet ${id}.`,
    };
}
export function getConfiguredWallet(network) {
    const walletId = ensureDefaultWalletId();
    const walletType = getWalletTypeForNetwork(network);
    const privateKey = readPrivateKeyFromConfig(walletId, walletType);
    const address = deriveAddressFromPrivateKey(privateKey, walletType);
    return {
        id: walletId,
        type: walletType,
        privateKey,
        address,
    };
}
export function getWalletAddress(network) {
    return getConfiguredWallet(network).address;
}
export function getWalletStorePath() {
    ensureWalletStoreLayout();
    return WALLET_DIR;
}
export async function getAgentWallet(network) {
    const walletId = ensureDefaultWalletId();
    const resolved = resolveWalletProvider({ dir: WALLET_DIR, network: toAgentNetwork(network) });
    if (resolved instanceof ConfigWalletProvider) {
        return resolved.getWallet(walletId, toAgentNetwork(network));
    }
    return resolveWallet({ dir: WALLET_DIR, network: toAgentNetwork(network), walletId });
}
export function resetWalletStore() {
    rmSync(WALLET_DIR, { recursive: true, force: true });
}
export function walletStoreExists() {
    try {
        return statSync(WALLET_DIR).isDirectory();
    }
    catch {
        return false;
    }
}
