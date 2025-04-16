const hre = require("hardhat");

async function main() {
  const signer = await hre.ethers.getSigners()[0];

  const deployments = require("../ignition/deployments/chain-31337/deployed_addresses.json");

  // Crete instance of RequestRegistry contract
  const requestRegistry = await hre.ethers.getContractAt(
    "RequestRegistry",
    deployments["DeploymentModule#RequestRegistry"],
    signer
  );

  // Define details of the request
  const doc_uris = [
    "https://s3.ap-south-1.amazonaws.com/ditto-partners/HDFC_Ergo_Optima_Secure_Policy_Wording_0c72f5369e.pdf"
  ]
  const query = "What is the average waiting period for pre-existing deseases ?"
  const assessment_parameters = []

  // Add request to RequestRegistry contract
  const tx = await requestRegistry.addRequest(doc_uris, query, assessment_parameters);
  await tx.wait();

  console.log("Request added to RequestRegistry contract");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });