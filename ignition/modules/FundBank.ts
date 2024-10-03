import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const MicjohnModule = buildModule("MicjohnModule", (m) => {

    const fundBank = m.contract("FundBank");

    return { fundBank };
});

export default MicjohnModule;