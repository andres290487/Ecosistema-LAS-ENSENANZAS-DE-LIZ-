export declare const ERC20_ABI: readonly [{
    readonly type: "function";
    readonly name: "name";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "string";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "symbol";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "string";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "decimals";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint8";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "totalSupply";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "balanceOf";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "account";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "allowance";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "owner";
    }, {
        readonly type: "address";
        readonly name: "spender";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "approve";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "spender";
    }, {
        readonly type: "uint256";
        readonly name: "amount";
    }];
    readonly outputs: readonly [{
        readonly type: "bool";
    }];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "transfer";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "to";
    }, {
        readonly type: "uint256";
        readonly name: "amount";
    }];
    readonly outputs: readonly [{
        readonly type: "bool";
    }];
    readonly stateMutability: "nonpayable";
}];
export declare const PROXY_REGISTRY_ABI: readonly [{
    readonly type: "function";
    readonly name: "build";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "address";
        readonly name: "proxy";
    }];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "build";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "owner";
    }];
    readonly outputs: readonly [{
        readonly type: "address";
        readonly name: "proxy";
    }];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "proxies";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "owner";
    }];
    readonly outputs: readonly [{
        readonly type: "address";
    }];
    readonly stateMutability: "view";
}];
export declare const PROXY_CALL_ABI: readonly [{
    readonly type: "function";
    readonly name: "execute";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "_target";
    }, {
        readonly type: "bytes";
        readonly name: "_data";
    }];
    readonly outputs: readonly [{
        readonly type: "bytes32";
        readonly name: "response";
    }];
    readonly stateMutability: "payable";
}, {
    readonly type: "function";
    readonly name: "owner";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "address";
    }];
    readonly stateMutability: "view";
}];
export declare const DSS_PROXY_ACTIONS_ABI: readonly [{
    readonly type: "function";
    readonly name: "open";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "bytes32";
        readonly name: "ilk";
    }, {
        readonly type: "address";
        readonly name: "usr";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
        readonly name: "cdp";
    }];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "openLockTRXAndDraw";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "address";
        readonly name: "jug";
    }, {
        readonly type: "address";
        readonly name: "trxJoin";
    }, {
        readonly type: "address";
        readonly name: "usddJoin";
    }, {
        readonly type: "bytes32";
        readonly name: "ilk";
    }, {
        readonly type: "uint256";
        readonly name: "wadD";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "payable";
}, {
    readonly type: "function";
    readonly name: "openLockGemAndDraw";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "address";
        readonly name: "jug";
    }, {
        readonly type: "address";
        readonly name: "gemJoin";
    }, {
        readonly type: "address";
        readonly name: "usddJoin";
    }, {
        readonly type: "bytes32";
        readonly name: "ilk";
    }, {
        readonly type: "uint256";
        readonly name: "amtC";
    }, {
        readonly type: "uint256";
        readonly name: "wadD";
    }, {
        readonly type: "bool";
        readonly name: "transferFrom";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "lockTRXAndDraw";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "address";
        readonly name: "jug";
    }, {
        readonly type: "address";
        readonly name: "trxJoin";
    }, {
        readonly type: "address";
        readonly name: "usddJoin";
    }, {
        readonly type: "uint256";
        readonly name: "cdp";
    }, {
        readonly type: "uint256";
        readonly name: "wadD";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "payable";
}, {
    readonly type: "function";
    readonly name: "lockGemAndDraw";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "address";
        readonly name: "jug";
    }, {
        readonly type: "address";
        readonly name: "gemJoin";
    }, {
        readonly type: "address";
        readonly name: "usddJoin";
    }, {
        readonly type: "uint256";
        readonly name: "cdp";
    }, {
        readonly type: "uint256";
        readonly name: "amtC";
    }, {
        readonly type: "uint256";
        readonly name: "wadD";
    }, {
        readonly type: "bool";
        readonly name: "transferFrom";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "draw";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "address";
        readonly name: "jug";
    }, {
        readonly type: "address";
        readonly name: "usddJoin";
    }, {
        readonly type: "uint256";
        readonly name: "cdp";
    }, {
        readonly type: "uint256";
        readonly name: "wad";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "wipe";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "address";
        readonly name: "usddJoin";
    }, {
        readonly type: "uint256";
        readonly name: "cdp";
    }, {
        readonly type: "uint256";
        readonly name: "wad";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "wipeAll";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "address";
        readonly name: "usddJoin";
    }, {
        readonly type: "uint256";
        readonly name: "cdp";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "safeWipeAll";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "address";
        readonly name: "usddJoin";
    }, {
        readonly type: "uint256";
        readonly name: "cdp";
    }, {
        readonly type: "address";
        readonly name: "owner";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "safeWipe";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "address";
        readonly name: "usddJoin";
    }, {
        readonly type: "uint256";
        readonly name: "cdp";
    }, {
        readonly type: "uint256";
        readonly name: "wad";
    }, {
        readonly type: "address";
        readonly name: "owner";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "freeTRX";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "address";
        readonly name: "trxJoin";
    }, {
        readonly type: "uint256";
        readonly name: "cdp";
    }, {
        readonly type: "uint256";
        readonly name: "wad";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "freeGem";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "address";
        readonly name: "gemJoin";
    }, {
        readonly type: "uint256";
        readonly name: "cdp";
    }, {
        readonly type: "uint256";
        readonly name: "amt";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "wipeAndFreeTRX";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "address";
        readonly name: "trxJoin";
    }, {
        readonly type: "address";
        readonly name: "usddJoin";
    }, {
        readonly type: "uint256";
        readonly name: "cdp";
    }, {
        readonly type: "uint256";
        readonly name: "wadC";
    }, {
        readonly type: "uint256";
        readonly name: "wadD";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "wipeAndFreeGem";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "address";
        readonly name: "gemJoin";
    }, {
        readonly type: "address";
        readonly name: "usddJoin";
    }, {
        readonly type: "uint256";
        readonly name: "cdp";
    }, {
        readonly type: "uint256";
        readonly name: "amtC";
    }, {
        readonly type: "uint256";
        readonly name: "wadD";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "wipeAllAndFreeTRX";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "address";
        readonly name: "trxJoin";
    }, {
        readonly type: "address";
        readonly name: "usddJoin";
    }, {
        readonly type: "uint256";
        readonly name: "cdp";
    }, {
        readonly type: "uint256";
        readonly name: "wadC";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "wipeAllAndFreeGem";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "manager";
    }, {
        readonly type: "address";
        readonly name: "gemJoin";
    }, {
        readonly type: "address";
        readonly name: "usddJoin";
    }, {
        readonly type: "uint256";
        readonly name: "cdp";
    }, {
        readonly type: "uint256";
        readonly name: "amtC";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "nonpayable";
}];
export declare const CDP_MANAGER_ABI: readonly [{
    readonly type: "function";
    readonly name: "count";
    readonly inputs: readonly [{
        readonly type: "address";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "first";
    readonly inputs: readonly [{
        readonly type: "address";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "list";
    readonly inputs: readonly [{
        readonly type: "uint256";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
        readonly name: "prev";
    }, {
        readonly type: "uint256";
        readonly name: "next";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "owns";
    readonly inputs: readonly [{
        readonly type: "uint256";
    }];
    readonly outputs: readonly [{
        readonly type: "address";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "urns";
    readonly inputs: readonly [{
        readonly type: "uint256";
    }];
    readonly outputs: readonly [{
        readonly type: "address";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "ilks";
    readonly inputs: readonly [{
        readonly type: "uint256";
    }];
    readonly outputs: readonly [{
        readonly type: "bytes32";
    }];
    readonly stateMutability: "view";
}];
export declare const VAT_ABI: readonly [{
    readonly type: "function";
    readonly name: "Line";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "debt";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "live";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "urns";
    readonly inputs: readonly [{
        readonly type: "bytes32";
    }, {
        readonly type: "address";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
        readonly name: "ink";
    }, {
        readonly type: "uint256";
        readonly name: "art";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "ilks";
    readonly inputs: readonly [{
        readonly type: "bytes32";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
        readonly name: "Art";
    }, {
        readonly type: "uint256";
        readonly name: "rate";
    }, {
        readonly type: "uint256";
        readonly name: "spot";
    }, {
        readonly type: "uint256";
        readonly name: "line";
    }, {
        readonly type: "uint256";
        readonly name: "dust";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "gem";
    readonly inputs: readonly [{
        readonly type: "bytes32";
    }, {
        readonly type: "address";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "usdd";
    readonly inputs: readonly [{
        readonly type: "address";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}];
export declare const JUG_ABI: readonly [{
    readonly type: "function";
    readonly name: "base";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "ilks";
    readonly inputs: readonly [{
        readonly type: "bytes32";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
        readonly name: "duty";
    }, {
        readonly type: "uint256";
        readonly name: "rho";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "drip";
    readonly inputs: readonly [{
        readonly type: "bytes32";
        readonly name: "ilk";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
        readonly name: "rate";
    }];
    readonly stateMutability: "nonpayable";
}];
export declare const SPOT_ABI: readonly [{
    readonly type: "function";
    readonly name: "par";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "live";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "ilks";
    readonly inputs: readonly [{
        readonly type: "bytes32";
    }];
    readonly outputs: readonly [{
        readonly type: "address";
        readonly name: "pip";
    }, {
        readonly type: "uint256";
        readonly name: "mat";
    }];
    readonly stateMutability: "view";
}];
export declare const OSM_ABI: readonly [{
    readonly type: "function";
    readonly name: "peek";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "bytes32";
    }, {
        readonly type: "bool";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "peep";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "bytes32";
    }, {
        readonly type: "bool";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "pass";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "bool";
        readonly name: "ok";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "hop";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint16";
    }];
    readonly stateMutability: "view";
}];
export declare const DOG_ABI: readonly [{
    readonly type: "function";
    readonly name: "Hole";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "Dirt";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "ilks";
    readonly inputs: readonly [{
        readonly type: "bytes32";
    }];
    readonly outputs: readonly [{
        readonly type: "address";
        readonly name: "clip";
    }, {
        readonly type: "uint256";
        readonly name: "chop";
    }, {
        readonly type: "uint256";
        readonly name: "hole";
    }, {
        readonly type: "uint256";
        readonly name: "dirt";
    }];
    readonly stateMutability: "view";
}];
export declare const PSM_ABI: readonly [{
    readonly type: "function";
    readonly name: "sellEnabled";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "buyEnabled";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "tin";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "tout";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "ilk";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "bytes32";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "sellGem";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "usr";
    }, {
        readonly type: "uint256";
        readonly name: "gemAmt";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "buyGem";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "usr";
    }, {
        readonly type: "uint256";
        readonly name: "gemAmt";
    }];
    readonly outputs: readonly [];
    readonly stateMutability: "nonpayable";
}];
export declare const DSR_POT_ABI: readonly [{
    readonly type: "function";
    readonly name: "chi";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "dsr";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "pie";
    readonly inputs: readonly [{
        readonly type: "address";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "drip";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "nonpayable";
}];
export declare const SUSDD_ABI: readonly [{
    readonly type: "function";
    readonly name: "asset";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "address";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "totalAssets";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "totalSupply";
    readonly inputs: readonly [];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "previewDeposit";
    readonly inputs: readonly [{
        readonly type: "uint256";
        readonly name: "assets";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "convertToAssets";
    readonly inputs: readonly [{
        readonly type: "uint256";
        readonly name: "shares";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "balanceOf";
    readonly inputs: readonly [{
        readonly type: "address";
        readonly name: "account";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
    }];
    readonly stateMutability: "view";
}, {
    readonly type: "function";
    readonly name: "deposit";
    readonly inputs: readonly [{
        readonly type: "uint256";
        readonly name: "assets";
    }, {
        readonly type: "address";
        readonly name: "receiver";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
        readonly name: "shares";
    }];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "withdraw";
    readonly inputs: readonly [{
        readonly type: "uint256";
        readonly name: "assets";
    }, {
        readonly type: "address";
        readonly name: "receiver";
    }, {
        readonly type: "address";
        readonly name: "owner";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
        readonly name: "shares";
    }];
    readonly stateMutability: "nonpayable";
}, {
    readonly type: "function";
    readonly name: "redeem";
    readonly inputs: readonly [{
        readonly type: "uint256";
        readonly name: "shares";
    }, {
        readonly type: "address";
        readonly name: "receiver";
    }, {
        readonly type: "address";
        readonly name: "owner";
    }];
    readonly outputs: readonly [{
        readonly type: "uint256";
        readonly name: "assets";
    }];
    readonly stateMutability: "nonpayable";
}];
