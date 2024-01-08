import { expect } from "chai";
import { Provider, Wallet } from "../src";
import { ethers, BigNumber } from "ethers";
import { TOKENS } from "./const";
import { ETH_ADDRESS, ETH_ADDRESS_IN_CONTRACTS } from "../src/utils";

import {
    ITestnetERC20TokenFactory,
} from "../typechain";

// This should be run first before all other tests,
// which is why it's specified first in the test command in package.json.
describe("setup",  () => {
    const PRIVATE_KEY = "0x7726827caac94a7f9e1b160f7ea819f172f7b6f9d2a97f992c38edeab82d4110";

    const provider = Provider.getDefaultProvider();
    const ethProvider = ethers.getDefaultProvider("http://localhost:8545");

    const wallet = new Wallet(PRIVATE_KEY, provider, ethProvider);

    it("should mint funds if needed", async () => {
        const bridgehub = await  wallet.getBridgehubContract();
        const chainId = (await wallet._providerL2().getNetwork()).chainId;
        let baseTokenAddress = await bridgehub.baseToken(chainId);
        baseTokenAddress = (baseTokenAddress == ETH_ADDRESS_IN_CONTRACTS) ? ETH_ADDRESS : baseTokenAddress;
        console.log("kl todo do we return early")

        if (baseTokenAddress == ETH_ADDRESS) {return}
        console.log("kl todo or not?")
        const testnetToken = ITestnetERC20TokenFactory.connect(baseTokenAddress, wallet._signerL1());
        await testnetToken.mint(await wallet.getAddress(), BigNumber.from("10000000000000000000"));
    }).timeout(25_000);

    it("deploy DAI token on L2 if not exists using deposit", async () => {
        const l2DAI = await provider.getCode(await provider.l2TokenAddress(TOKENS.DAI.address));
        if (l2DAI === "0x") {
            const priorityOpResponse = await wallet.deposit({
                token: TOKENS.DAI.address,
                to: await wallet.getAddress(),
                amount: 30,
                approveERC20: true,
                approveBaseERC20: true,
                refundRecipient: await wallet.getAddress(),
            });
            const receipt = await priorityOpResponse.waitFinalize();
            expect(receipt).not.to.be.null;
        }
    }).timeout(25_000);

    it("should send funds to l2", async () => {
        const bridgehub = await  wallet.getBridgehubContract();
        const chainId = (await wallet._providerL2().getNetwork()).chainId;
        let baseTokenAddress = await bridgehub.baseToken(chainId);
        baseTokenAddress = (baseTokenAddress == ETH_ADDRESS_IN_CONTRACTS) ? ETH_ADDRESS : baseTokenAddress;

        const priorityOpResponse = await wallet.deposit({
            token: baseTokenAddress,
            to: await wallet.getAddress(),
            amount: 334728500000000,
            approveERC20: true,
            refundRecipient: await wallet.getAddress(),
        });
        const receipt = await priorityOpResponse.waitFinalize();
        expect(receipt).not.to.be.null;
    }).timeout(75_000);
});
