const hre = require("hardhat");
const readline = require("readline");

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function askQuestion(query) {
  return new Promise((resolve) => {
    rl.question(query, (answer) => {
      resolve(answer);
    });
  });
}

async function takeDocUris() {
  console.log("Please enter Document URIs (one per line): \n");
  console.log("When finished, enter an empty line to continue \n")

  const docUris = []
  let inputUri = " ";

  while (inputUri !== "") {
    inputUri = await askQuestion("Document URI: ");
    if (inputUri !== "") {
      docUris.push(inputUri.trim());
    }
  }

  return docUris;
}

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
  const doc_uris = await takeDocUris();
  const query = await askQuestion("Enter your query: ");

  if (query.trim() === "") {
    throw new Error("Query cannot be empty")
  }

  const assessment_parameters = [];

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