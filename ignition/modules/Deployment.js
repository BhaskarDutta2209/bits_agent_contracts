const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("DeploymentModule", (m) => {
  const identityFactory = m.contract("IdentityFactory", [], {});
  const requestRegistry = m.contract("RequestRegistry", [], {});
  // const policyRegistry = m.contract("PolicyRegistry", [], {});
  // const ratingContractRegistry = m.contract("RatingContractRegistry", [], {});
  // const ratingContract = m.contract("RatingContract", [], {});
  // const requestRegistry = m.contract("RequestRegistry", [], {});

  return { identityFactory, requestRegistry };
});
