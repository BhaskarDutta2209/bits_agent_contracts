const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("DeploymentModule", (m) => {
  const responseRegistry = m.contract("ResponseRegistry", [], {});
  const identityFactory = m.contract("IdentityFactory", [], {});
  const requestRegistry = m.contract("RequestRegistry", [], {});

  return { responseRegistry, identityFactory, requestRegistry };
});
