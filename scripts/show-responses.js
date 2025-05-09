const hre = require("hardhat");
const prompt = require("prompt");

async function main() {
  const signer = (await hre.ethers.getSigners())[0];

  const deployments = require("../ignition/deployments/chain-31337/deployed_addresses.json");

  const responseRegistry = await hre.ethers.getContractAt(
    "ResponseRegistry",
    deployments["DeploymentModule#ResponseRegistry"],
    signer
  );

  const requestId = Object.values(await prompt.get("Enter requestId: "))[0]

  const responseCount = await responseRegistry.getResponseCount(requestId);
  const summary = await responseRegistry.summary(requestId);

  console.log("Responses for requestId", requestId);
  console.log("Total responses:", responseCount);
  console.log("Summary:", summary);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });