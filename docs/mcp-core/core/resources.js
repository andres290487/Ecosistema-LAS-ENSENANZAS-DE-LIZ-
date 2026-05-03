import { NETWORKS } from "./chains.js";
import { utils } from "./services/utils.js";
export function registerUsddResources(server) {
    server.registerResource("usdd://protocol-info", "usdd://protocol-info", {
        description: "Static USDD protocol deployment information across supported networks.",
        mimeType: "application/json",
    }, async () => ({
        contents: [{
                uri: "usdd://protocol-info",
                mimeType: "application/json",
                text: utils.formatJson(NETWORKS),
            }],
    }));
}
